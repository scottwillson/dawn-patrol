package db

import (
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestCreate(t *testing.T) {
	db := Open()
	defer db.Close()

	db.Delete(api.Event{})

	es := EventService{DB: db, Logger: &log.MockLogger{}}

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race"},
		api.Event{Name: "Sausalito Criterium"},
	}
	es.Create(events)

	events = es.Find()

	sort.Sort(api.ByName(events))

	assert := assert.New(t)
	assert.Equal(2, len(events), "events")
	assert.Equal("Copperopolis Road Race", events[0].Name, "event name")
	assert.Equal("Sausalito Criterium", events[1].Name, "event name")
}

func TestFind(t *testing.T) {
	db := Open()
	defer db.Close()

	db.Delete(&api.Event{})
	db.Create(&api.Event{})
	db.Create(&api.Event{})

	es := EventService{DB: db, Logger: &log.MockLogger{}}

	var events = es.Find()
	assert.Equal(t, 2, len(events), "events")
}

func TestByName(t *testing.T) {
	events := []api.Event{}
	sort.Sort(api.ByName(events))

	events = []api.Event{
		api.Event{Name: "Sausalito Criterium"},
		api.Event{Name: "Copperopolis Road Race"},
	}

	sort.Sort(api.ByName(events))

	assert := assert.New(t)
	assert.Equal(2, len(events), "events")
	assert.Equal("Copperopolis Road Race", events[0].Name, "event name")
	assert.Equal("Sausalito Criterium", events[1].Name, "event name")
}
