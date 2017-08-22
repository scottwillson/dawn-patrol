package rails

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api/mock"

	goji "goji.io"
	"goji.io/pat"
)

func TestRailsService(t *testing.T) {
	mux := goji.NewMux()

	var service mock.RailsService
	var handler Copy
	handler.RailsService = &service

	service.CopyFn = func() bool {
		return true
	}

	req, err := http.NewRequest("POST", "/rails/copy", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Post("/rails/copy"), &handler)

	mux.ServeHTTP(resp, req)

	if status := resp.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}
}