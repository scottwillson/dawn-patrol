package db

import (
	"os"
	"testing"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
)

func TestNewInstrumentedEventService(t *testing.T) {
	_, db, logger := SetupTest()
	defer db.Close()

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	nr := api.NewNewRelicApp(logger)

	var es api.EventService
	es = &EventService{DB: db, Logger: logger}
	es = NewInstrumentedEventService(nr, es)

	es.Create([]api.Event{})
	es.Find(&api.Association{})
}
