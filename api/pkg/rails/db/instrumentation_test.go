package db

import (
	"os"
	"testing"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/mock"
)

func TestNewInstrumentedEventService(t *testing.T) {
	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()
	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	logger := log.MockLogger{}
	nr := api.NewNewRelicApp(&logger)

	service := &mock.EventService{}

	instrumentedService := NewInstrumentedEventService(nr, service)

	instrumentedService.Find("MOCK")
}

func TestNewInstrumentedRacingAssociationService(t *testing.T) {
	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()
	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	logger := log.MockLogger{}
	nr := api.NewNewRelicApp(&logger)

	service := &mock.RacingAssociationService{}

	instrumentedService := NewInstrumentedRacingAssociationService(nr, service)

	if err := instrumentedService.Copy("MOCK"); err != nil {
		t.Error(err)
	}
}
