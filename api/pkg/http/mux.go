package http

import (
	newrelic "github.com/newrelic/go-agent"
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
	mux.Handle(pat.Get("/index.json"), NewInstrumentedHandler(cfg.NewRelicApp, newRoot(cfg.EventService)))
	mux.Handle(pat.Post("/rails/copy"), NewInstrumentedHandler(cfg.NewRelicApp, &railsHttp.Copy{cfg.RailsEventService}))

	return mux
}
