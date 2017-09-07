package main

import (
	"os"

	"github.com/go-kit/kit/log"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
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
	dpDB := db.Open(dbLogger)
	defer dpDB.Close()

	esLogger := log.With(logger, "component", "event-service")
	es := db.NewInstrumentedEventService(nr, &db.EventService{DB: dpDB, Logger: esLogger})

	mysql := railsDB.Open(dbLogger)
	defer mysql.Close()

	railsESLogger := log.With(logger, "component", "rails-event-service")
	railsES := &railsDB.EventService{DB: mysql, APIEventService: es, Logger: railsESLogger}

	mux := http.NewMux(http.MuxConfig{
		EventService:      es,
		NewRelicApp:       nr,
		RailsEventService: railsES,
	})

	http.ListenAndServe(mux)
}
