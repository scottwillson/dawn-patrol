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

	stdprometheus "github.com/prometheus/client_golang/prometheus"

	kitprometheus "github.com/go-kit/kit/metrics/prometheus"
)

func main() {
	fieldKeys := []string{"method"}

	logger := log.NewLogfmtLogger(log.NewSyncWriter(os.Stderr))
	log.With(logger, "at", log.DefaultTimestampUTC)

	dpDB := db.Open()
	defer dpDB.Close()

	esLogger := log.With(logger, "component", "event-service")
	var es api.EventService
	es = &db.EventService{DB: dpDB, Logger: esLogger}

	es = api.NewInstrumentingService(
		kitprometheus.NewCounterFrom(stdprometheus.CounterOpts{
			Namespace: "api",
			Subsystem: "event_service",
			Name:      "request_count",
			Help:      "Number of requests received.",
		}, fieldKeys),
		kitprometheus.NewSummaryFrom(stdprometheus.SummaryOpts{
			Namespace: "api",
			Subsystem: "event_service",
			Name:      "request_latency_microseconds",
			Help:      "Total duration of requests in microseconds.",
		}, fieldKeys),
		es,
	)

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
