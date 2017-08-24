package http

import (
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api"
	"rocketsurgeryllc.com/dawnpatrol/api/mock"

	goji "goji.io"
	"goji.io/pat"
)

type ErroringRootEventJSON struct{}

func (h *ErroringRootEventJSON) marshal(events []api.Event) (string, error) {
	return "", errors.New("Parsing failed")
}

func TestRoot(t *testing.T) {
	mux := goji.NewMux()

	es := mock.EventService{}
	h := newRoot(&es)

	es.FindFn = func() []api.Event {
		return []api.Event{api.Event{}}
	}

	req, err := http.NewRequest("GET", "/index.json", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Get("/index.json"), h)

	mux.ServeHTTP(resp, req)

	assert := assert.New(t)
	assert.Equal(http.StatusOK, resp.Code, "handler status code")

	var events []api.Event
	e := json.Unmarshal(resp.Body.Bytes(), &events)
	if e != nil {
		t.Error(e)
	}

	assert.Equal(1, len(events), "events")
}

func TestRootServicError(t *testing.T) {
	mux := goji.NewMux()

	var es mock.EventService
	h := Root{EventJSON: &ErroringRootEventJSON{}, EventService: &es}

	es.FindFn = func() []api.Event {
		return []api.Event{api.Event{}}
	}

	req, err := http.NewRequest("GET", "/index.json", nil)
	if err != nil {
		t.Fatal(err)
	}

	resp := httptest.NewRecorder()
	mux.Handle(pat.Get("/index.json"), &h)

	assert.Panics(t, func() { mux.ServeHTTP(resp, req) })
}
