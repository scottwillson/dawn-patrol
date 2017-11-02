package http

import (
	"encoding/json"
	"fmt"
	"net/http"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
)

// Root returns an array of Events as JSON.
type Root struct {
	AssociationService api.AssociationService
	EventJSON          EventJSON
	EventService       api.EventService
}

// EventJSON marshals Events to JSON string.
type EventJSON interface {
	marshal(events []api.Event) (string, error)
}

// DefaultEventJSON implements EventJSON. Allows tests to mock JSON marshalling.
type DefaultEventJSON struct{}

func (h *DefaultEventJSON) marshal(events []api.Event) (string, error) {
	jsonOut, err := json.Marshal(events)
	return string(jsonOut), err
}

func newRoot(as api.AssociationService, es api.EventService) *Root {
	return &Root{
		AssociationService: as,
		EventJSON:          &DefaultEventJSON{},
		EventService:       es,
	}
}

func (h *Root) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	acronym := h.AssociationService.FirstAcronymByHost(r.Host)
	events, err := h.EventService.Find(acronym)
	if err != nil {
		panic(err)
	}

	jsonOut, err := h.EventJSON.marshal(events)
	if err != nil {
		panic(err)
	}

	w.Header().Set("Content-Type", "application/json")

	fmt.Fprintf(w, jsonOut)
}
