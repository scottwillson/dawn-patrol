package http

import (
	"net/http"
)

// TestPanic is a simple HTTP handler that always returns an error
type TestPanic struct{}

func newTestPanic() *TestPanic {
	return &TestPanic{}
}

func (h *TestPanic) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	panic("Parsing failed")
}
