package http

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/mock"

	goji "goji.io"
	"goji.io/pat"
)

func TestCopy(t *testing.T) {
	mux := goji.NewMux()

	handler := Copy{EventService: &mock.EventService{}}

	req, _ := http.NewRequest("POST", "/rails/copy", strings.NewReader("association=rails"))
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	resp := httptest.NewRecorder()
	mux.Handle(pat.Post("/rails/copy"), &handler)

	mux.ServeHTTP(resp, req)

	assert.Equal(t, http.StatusOK, resp.Code, "handler status code")
}

func TestCopyRequiresAssociation(t *testing.T) {
	mux := goji.NewMux()

	handler := Copy{EventService: &mock.EventService{}}

	req, err := http.NewRequest("POST", "/rails/copy", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Post("/rails/copy"), &handler)

	mux.ServeHTTP(resp, req)

	assert.Equal(t, http.StatusBadRequest, resp.Code, "handler status code")
}
