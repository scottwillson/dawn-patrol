package http

import (
	"net/http"

	raven "github.com/getsentry/raven-go"
	newrelic "github.com/newrelic/go-agent"
	goji "goji.io"
	"goji.io/pat"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// MuxConfig holds configuration and dependencies for a goji.Mu instance.
// EventService: main api EventService.
// NewRelicApp: New Relic configuration.
// RailsEventService: Rails EventService.
type MuxConfig struct {
	AssociationService       api.AssociationService
	EventService             api.EventService
	NewRelicApp              newrelic.Application
	RacingAssociationService rails.RacingAssociationService
	RailsEventService        rails.EventService
}

// NewMux creates a new HTTP multiplexer.
func NewMux(cfg MuxConfig) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	var handler http.Handler = NewInstrumentedHandler(cfg.NewRelicApp, newRoot(cfg.AssociationService, cfg.EventService))
	handler = newRoot(cfg.AssociationService, cfg.EventService)
	mux.HandleFunc(pat.Get("/index.json"), raven.RecoveryHandler(handler.ServeHTTP))
	// mux.Handle(pat.Post("/rails/copy"), raven.RecoveryHandler(NewInstrumentedHandler(cfg.NewRelicApp, &railsHttp.Copy{RacingAssociationService: cfg.RacingAssociationService})))
	// mux.Handle(pat.Get("/status"), raven.RecoveryHandler(NewInstrumentedHandler(cfg.NewRelicApp, newStatus())))

	return mux
}
