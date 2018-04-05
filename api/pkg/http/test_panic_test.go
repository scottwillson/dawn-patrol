package http

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
	goji "goji.io"
	"goji.io/pat"
)

func TestPanicTest(t *testing.T) {
	mux := goji.NewMux()
	h := newTestPanic()

	req, err := http.NewRequest("GET", "/panic", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Get("/panic"), h)

	assert.Panics(t, func() { mux.ServeHTTP(resp, req) })
}
