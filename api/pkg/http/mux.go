package http

import (
	goji "goji.io"
	"goji.io/pat"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
	railsHttp "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/http"
)

// NewMux creates a new HTTP multiplexer
func NewMux(es api.EventService, railsES rails.EventService) *goji.Mux {
	mux := goji.NewMux()

	mux.Use(log.Request)
	mux.Handle(pat.Get("/index.json"), newRoot(es))
	mux.Handle(pat.Post("/rails/copy"), &railsHttp.Copy{railsES})

	return mux
}
