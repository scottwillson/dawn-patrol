package http

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"

	goji "goji.io"
	"goji.io/pat"
)

func TestStatus(t *testing.T) {
	mux := goji.NewMux()
	h := newStatus()

	req, err := http.NewRequest("GET", "/status", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Get("/status"), h)

	mux.ServeHTTP(resp, req)

	assert := assert.New(t)
	assert.Equal(http.StatusOK, resp.Code, "handler status code")
}
