package db

import (
	"os"
	"testing"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

func TestNewInstrumentedEventService(t *testing.T) {
	logger := log.MockLogger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	nr := api.NewNewRelicApp(&logger)

	dpDB := db.Open(&logger)
	defer dpDB.Close()

	dpDB.Delete(api.Event{})

	railsDB := Open(&logger)
	defer railsDB.Close()

	eventService := &db.EventService{DB: dpDB, Logger: &logger}

	var railsService rails.EventService
	railsService = &EventService{DB: railsDB, APIEventService: eventService, Logger: &log.MockLogger{}}
	railsService = NewInstrumentedEventService(nr, railsService)

	if err := railsService.Copy(); err != nil {
		t.Error(err)
	}

	railsService.Find()
}
