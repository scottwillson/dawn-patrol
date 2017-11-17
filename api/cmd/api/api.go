package main

import (
	"os"

	"github.com/go-kit/kit/log"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/http"
	railsDB "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/db"
)

func main() {
	var logger = log.NewLogfmtLogger(log.NewSyncWriter(os.Stderr))
	logger = log.With(logger, "at", log.DefaultTimestampUTC)

	nr := api.NewNewRelicApp(logger)

	dbLogger := log.With(logger, "component", "db")
	dbs := db.Databases{Logger: dbLogger}
	dpDB := dbs.Default()
	defer dpDB.Close()

	asLogger := log.With(logger, "component", "association-service")
	as := db.NewInstrumentedAssociationService(nr, &db.AssociationService{DB: dpDB, Logger: asLogger})

	esLogger := log.With(logger, "component", "event-service")
	es := db.NewInstrumentedEventService(nr, &db.EventService{DB: dpDB, Logger: esLogger})

	railsRAServiceLogger := log.With(logger, "component", "rails-racing-association-service")
	railsRAService := railsDB.RacingAssociationService{
		APIEventService:    es,
		AssociationService: as,
		Databases:          dbs,
		Logger:             railsRAServiceLogger,
	}

	railsESLogger := log.With(logger, "component", "rails-event-service")
	railsES := &railsDB.EventService{
		Databases: dbs,
		Logger:    railsESLogger,
		RacingAssociationService: &railsRAService,
	}

	mux := http.NewMux(http.MuxConfig{
		AssociationService:       as,
		EventService:             es,
		NewRelicApp:              nr,
		RacingAssociationService: &railsRAService,
		RailsEventService:        railsES,
	})

	http.ListenAndServe(mux)
}
