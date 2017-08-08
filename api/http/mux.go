package http

import (
	goji "goji.io"
	"goji.io/pat"
	"rocketsurgeryllc.com/dawnpatrol/api"
	"rocketsurgeryllc.com/dawnpatrol/api/log"
)

// NewMux creates a new HTTP multiplexer
func NewMux(es api.EventService) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	mux.Handle(pat.Get("/index.json"), &Root{es})

	return mux
}
