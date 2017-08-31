package main

import (
	"os"

	"github.com/go-kit/kit/log"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/http"
	railsDB "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/db"
)

func main() {
	logger := log.NewLogfmtLogger(log.NewSyncWriter(os.Stderr))
	log.With(logger, "at", log.DefaultTimestampUTC)

	dpDB := db.Open()
	defer dpDB.Close()

	esLogger := log.With(logger, "component", "event-service")
	es := &db.EventService{DB: dpDB, Logger: esLogger}

	mysql := railsDB.Open()
	defer mysql.Close()

	railsESLogger := log.With(logger, "component", "rails-event-service")
	railsES := &railsDB.EventService{DB: mysql, APIEventService: es, Logger: railsESLogger}

	mux := http.NewMux(http.MuxConfig{
		EventService:      es,
		RailsEventService: railsES,
	})
	http.ListenAndServe(mux)
}
