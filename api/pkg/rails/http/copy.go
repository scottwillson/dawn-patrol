package http

import (
	"net/http"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// Copy starts a copy of Racing on Rails data.
type Copy struct {
	EventService             rails.EventService
	RacingAssociationService rails.RacingAssociationService
}

func (h *Copy) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	association := r.PostFormValue("association")
	if association == "" {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	if err := h.EventService.Copy(association); err != nil {
		panic(err)
	}
}
