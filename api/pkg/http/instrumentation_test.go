package http

import (
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/mock"

	"github.com/stretchr/testify/assert"
)

func TestDefaultNewNewRelicApp(t *testing.T) {
	logger := mock.Logger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "")

	nr := NewNewRelicApp(&logger)

	assert.Nil(t, nr, "NewRelicApp")
}

func TestNewNewRelicAppWithLicense(t *testing.T) {
	logger := mock.Logger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	nr := NewNewRelicApp(&logger)

	assert.NotNil(t, nr, "NewRelicApp")
}

func TestNewNewRelicAppPanics(t *testing.T) {
	logger := mock.Logger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "1337")

	assert.Panics(t, func() { NewNewRelicApp(&logger) }, "Present, but invalid license panics")
}

func TestNewInstrumentedHandler(t *testing.T) {
	logger := mock.Logger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	app := NewNewRelicApp(&logger)

	es := mock.EventService{}
	h := NewInstrumentedHandler(app, newRoot(&es))

	assert.NotNil(t, h, "instrumented NewRelicApp")

	w := httptest.NewRecorder()
	r, err := http.NewRequest("GET", "/index.json", nil)
	if err != nil {
		t.Fatal(err)
	}

	h.ServeHTTP(w, r)
}
