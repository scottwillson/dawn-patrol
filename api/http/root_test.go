package http

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api"
	"rocketsurgeryllc.com/dawnpatrol/api/mock"

	goji "goji.io"
	"goji.io/pat"
)

func TestRoot(t *testing.T) {
	mux := goji.NewMux()

	var es mock.EventService
	var h Root
	h.EventService = &es

	es.FindFn = func() []api.Event {
		return []api.Event{api.Event{}}
	}

	req, err := http.NewRequest("GET", "/index.json", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Get("/index.json"), &h)

	mux.ServeHTTP(resp, req)

	if status := resp.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	var events []api.Event
	e := json.Unmarshal(resp.Body.Bytes(), &events)
	if e != nil {
		t.Error(e)
	}

	if len(events) != 1 {
		t.Errorf("Expect events len to be 1, but is %v", len(events))
	}
}
