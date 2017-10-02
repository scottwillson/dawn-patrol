package db

import (
	"os"
	"testing"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestNewInstrumentedEventService(t *testing.T) {
	logger := log.MockLogger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	nr := api.NewNewRelicApp(&logger)
	dbs := db.Databases{Logger: &logger}

	dpDB := dbs.Default()
	defer dpDB.Close()

	eventService := &db.EventService{DB: dpDB, Logger: &logger}
	railsService := &EventService{Databases: dbs, APIEventService: eventService, Logger: &logger}

	instrumentedService := NewInstrumentedEventService(nr, railsService)

	if err := instrumentedService.Copy("rails"); err != nil {
		t.Error(err)
	}

	instrumentedService.Find("rails")
}
