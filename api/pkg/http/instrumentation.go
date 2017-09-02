package http

import (
	"fmt"
	"net/http"
	"os"

	"github.com/go-kit/kit/log"
	newrelic "github.com/newrelic/go-agent"
)

type instrumentedHandler struct {
	NewRelicApp newrelic.Application
	Handler     http.Handler
}

// NewNewRelicApp creates a new New Relic Application with license set from NEW_RELIC_LICENSE_KEY.
// The New Relic app name is set from DAWN_PATROL_ENVIRONMENT, and defaults to just 'Dawn Patrol' (production).
func NewNewRelicApp(logger log.Logger) newrelic.Application {
	license := os.Getenv("NEW_RELIC_LICENSE_KEY")
	if license == "" {
		logger.Log("component", "instrumentation", "new_relic_license_key", false)
		return nil
	}

	config := newrelic.NewConfig(appName(), license)
	app, err := newrelic.NewApplication(config)
	if err != nil {
		panic(err)
	}

	return app
}

// NewInstrumentedHandler instruments an HTTP Handler with New Relic. It starts a New Relic transaction and then delegates to the Handler's
// ServeHTTP() function. This function returns the wrapped Handler.
func NewInstrumentedHandler(nr newrelic.Application, h http.Handler) http.Handler {
	if nr == nil {
		return h
	}

	return &instrumentedHandler{
		NewRelicApp: nr,
		Handler:     h,
	}
}

func (ih *instrumentedHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h := ih.Handler

	txn := ih.NewRelicApp.StartTransaction(fmt.Sprintf("%T", h), w, r)
	defer txn.End()

	h.ServeHTTP(w, r)
}

func appName() string {
	dpEnv := os.Getenv("DAWN_PATROL_ENVIRONMENT")
	if dpEnv == "" {
		return "Dawn Patrol"
	}
	return "Dawn Patrol " + dpEnv
}
