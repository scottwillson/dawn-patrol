package http

import (
	goji "goji.io"
	"goji.io/pat"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
	railsHttp "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/http"
)

type MuxConfig struct {
	EventService      api.EventService
	RailsEventService rails.EventService
}

// NewMux creates a new HTTP multiplexer.
func NewMux(cfg MuxConfig) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	mux.Handle(pat.Get("/index.json"), newRoot(cfg.EventService))
	mux.Handle(pat.Post("/rails/copy"), &railsHttp.Copy{cfg.RailsEventService})

	return mux
}
