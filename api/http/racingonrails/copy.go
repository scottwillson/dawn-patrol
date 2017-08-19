package racingonrails

import (
	"net/http"

	"rocketsurgeryllc.com/dawnpatrol/api"
)

// Copy starts a copy of Racing on Rails data
type Copy struct {
	RacingOnRailsService api.RacingOnRailsService
}

func (h *Copy) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h.RacingOnRailsService.Copy()
}
