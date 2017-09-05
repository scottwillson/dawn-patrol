package api

import (
	"os"
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"

	"github.com/stretchr/testify/assert"
)

func TestDefaultNewNewRelicApp(t *testing.T) {
	logger := log.MockLogger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "")

	nr := NewNewRelicApp(&logger)

	assert.Nil(t, nr, "NewRelicApp")
}

func TestNewNewRelicAppWithLicense(t *testing.T) {
	logger := log.MockLogger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	nr := NewNewRelicApp(&logger)

	assert.NotNil(t, nr, "NewRelicApp")
}

func TestNewNewRelicAppPanics(t *testing.T) {
	logger := log.MockLogger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "1337")

	assert.Panics(t, func() { NewNewRelicApp(&logger) }, "Present, but invalid license panics")
}
