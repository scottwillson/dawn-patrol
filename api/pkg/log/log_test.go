package log

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

type testHandler struct{}

func (h testHandler) ServeHTTP(http.ResponseWriter, *http.Request) {}

func TestRequest(t *testing.T) {
	loggingHandle := Request(testHandler{})

	resp := httptest.NewRecorder()

	req, err := http.NewRequest("GET", "/index.json", nil)
	if err != nil {
		t.Fatal(err)
	}

	loggingHandle.ServeHTTP(resp, req)
}
