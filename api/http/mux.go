package http

import (
	goji "goji.io"
	"goji.io/pat"
	"rocketsurgeryllc.com/dawnpatrol/api"
	"rocketsurgeryllc.com/dawnpatrol/api/http/racingonrails"
	"rocketsurgeryllc.com/dawnpatrol/api/log"
)

// NewMux creates a new HTTP multiplexer
func NewMux(es api.EventService, rors api.RacingOnRailsService) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	mux.Handle(pat.Get("/index.json"), &Root{es})
	mux.Handle(pat.Post("/racing-on-rails/copy"), &racingonrails.Copy{rors})

	return mux
}
