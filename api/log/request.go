package log

import (
	"fmt"
	"net/http"
)

// Request logs the request URL to stdout
func Request(h http.Handler) http.Handler {
	fn := func(w http.ResponseWriter, r *http.Request) {
		fmt.Printf("Handle %v\n", r.URL)
		h.ServeHTTP(w, r)
	}
	return http.HandlerFunc(fn)
}
