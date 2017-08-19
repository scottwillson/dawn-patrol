package http

import (
	goji "goji.io"
	"goji.io/pat"
	"rocketsurgeryllc.com/dawnpatrol/api"
	"rocketsurgeryllc.com/dawnpatrol/api/http/rails"
	"rocketsurgeryllc.com/dawnpatrol/api/log"
)

// NewMux creates a new HTTP multiplexer
func NewMux(es api.EventService, rs api.RailsService) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	mux.Handle(pat.Get("/index.json"), &Root{es})
	mux.Handle(pat.Post("/rails/copy"), &rails.Copy{rs})

	return mux
}
