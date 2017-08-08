package api

import (
	"testing"
)

func TestEvent(t *testing.T) {
	event := Event{}

	if event.Name != "" {
		t.Errorf("Expect default name to be '', but was %v", event.Name)
	}
}
