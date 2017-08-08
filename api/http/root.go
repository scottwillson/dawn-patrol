package http

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"rocketsurgeryllc.com/dawnpatrol/api"
)

// Root returns array of Events as JSON
type Root struct {
	EventService api.EventService
}

func (h *Root) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	events := h.EventService.Find()
	jsonOut, err := json.Marshal(events)
	if err != nil {
		log.Fatal(err)
	}

	w.Header().Set("Content-Type", "application/json")

	fmt.Fprintf(w, string(jsonOut))
}
