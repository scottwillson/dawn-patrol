package http

import (
	newrelic "github.com/newrelic/go-agent"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	goji "goji.io"
	"goji.io/pat"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
	railsHttp "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/http"
)

// MuxConfig holds configuration and dependencies for a goji.Mu instance.
// EventService: main api EventService.
// NewRelicApp: New Relic configuration.
// RailsEventService: Rails EventService.
type MuxConfig struct {
	EventService      api.EventService
	NewRelicApp       newrelic.Application
	RailsEventService rails.EventService
}

// NewMux creates a new HTTP multiplexer.
func NewMux(cfg MuxConfig) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	mux.Handle(pat.Get("/index.json"), newRoot(cfg.EventService))
	mux.Handle(pat.Get("/metrics"), promhttp.Handler())
	mux.Handle(pat.Post("/rails/copy"), &railsHttp.Copy{cfg.RailsEventService})
	mux.Handle(pat.Get("/status"), NewInstrumentedHandler(cfg.NewRelicApp, newStatus()))

	return mux
}
