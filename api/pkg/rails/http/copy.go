package http

import (
	"net/http"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// Copy starts a copy of Racing on Rails data.
type Copy struct {
	EventService rails.EventService
}

func (h *Copy) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h.EventService.Copy()
}
