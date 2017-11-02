package http

import (
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/mock"

	"github.com/stretchr/testify/assert"
)

func TestNewInstrumentedHandler(t *testing.T) {
	logger := log.MockLogger{}

	originalLicense := os.Getenv("NEW_RELIC_LICENSE_KEY")
	defer func() { os.Setenv("NEW_RELIC_LICENSE_KEY", originalLicense) }()

	os.Setenv("NEW_RELIC_LICENSE_KEY", "0123456789012345678901234567890123456789")

	app := api.NewNewRelicApp(&logger)

	as := mock.AssociationService{}
	es := mock.EventService{}
	h := NewInstrumentedHandler(app, newRoot(&as, &es))

	assert.NotNil(t, h, "instrumented Handler")

	w := httptest.NewRecorder()
	r, err := http.NewRequest("GET", "/index.json", nil)
	if err != nil {
		t.Fatal(err)
	}

	h.ServeHTTP(w, r)
}
