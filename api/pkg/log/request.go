package log

import (
	"net/http"
	"os"

	"github.com/go-kit/kit/log"
)

// Request logs the request URL to go-kit logger. Can't pass dependencies, so use global logger.
func Request(h http.Handler) http.Handler {
	logger := log.NewLogfmtLogger(log.NewSyncWriter(os.Stderr))
	log.With(logger, "at", log.DefaultTimestampUTC)

	fn := func(w http.ResponseWriter, r *http.Request) {
		logger.Log("component", "http", "method", r.Method, "url", r.URL)
		h.ServeHTTP(w, r)
	}
	return http.HandlerFunc(fn)
}
