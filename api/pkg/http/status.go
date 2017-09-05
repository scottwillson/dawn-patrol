package http

import (
	"fmt"
	"net/http"
)

// Status returns app status.
type Status struct{}

func newStatus() *Status {
	return &Status{}
}

func (h *Status) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "ok")
}
