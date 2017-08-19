package rails

import (
	"net/http"

	"rocketsurgeryllc.com/dawnpatrol/api"
)

// Copy starts a copy of Racing on Rails data
type Copy struct {
	RailsService api.RailsService
}

func (h *Copy) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h.RailsService.Copy()
}
