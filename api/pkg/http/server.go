package http

import (
	"net/http"

	goji "goji.io"
)

// ListenAndServe starts an HTTP server with this multiplexer.
func ListenAndServe(mux *goji.Mux) {
	http.ListenAndServe(":8080", mux)
}
