package api

import (
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestEvent(t *testing.T) {
	event := Event{}

	if event.Name != "" {
		t.Errorf("Expect default name to be '', but was %v", event.Name)
	}
}

func TestByName(t *testing.T) {
	events := []Event{}
	sort.Sort(ByName(events))

	events = []Event{
		Event{Name: "Sausalito Criterium"},
		Event{Name: "Copperopolis Road Race"},
	}

	sort.Sort(ByName(events))

	assert := assert.New(t)
	assert.Equal(2, len(events), "events")
	assert.Equal("Copperopolis Road Race", events[0].Name, "event name")
	assert.Equal("Sausalito Criterium", events[1].Name, "event name")
}
