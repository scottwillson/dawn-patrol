package http

import (
	"fmt"
	"net/http"

	raven "github.com/getsentry/raven-go"
	newrelic "github.com/newrelic/go-agent"
)

type instrumentedHandler struct {
	NewRelicApp newrelic.Application
	Handler     http.Handler
}

// NewInstrumentedHandler instruments an HTTP Handler with New Relic. It starts a New Relic transaction and then delegates to the Handler's
// ServeHTTP() function. This function returns the wrapped Handler.
func NewInstrumentedHandler(nr newrelic.Application, h http.Handler) http.Handler {
	return &instrumentedHandler{
		NewRelicApp: nr,
		Handler:     h,
	}
}

func (ih *instrumentedHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h := ih.Handler

	if ih.NewRelicApp != nil {
		txn := ih.NewRelicApp.StartTransaction(fmt.Sprintf("%T", h), w, r)
		defer txn.End()
	}

	rh := raven.RecoveryHandler(h.ServeHTTP)
	rh(w, r)
}
