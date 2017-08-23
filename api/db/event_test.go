package db

import (
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api"
)

type ByName []api.Event

func (a ByName) Len() int           { return len(a) }
func (a ByName) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByName) Less(i, j int) bool { return a[i].Name < a[j].Name }

func TestCreate(t *testing.T) {
	db := Open()
	defer db.Close()

	db.Delete(api.Event{})

	var service EventService
	service.DB = db

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race"},
		api.Event{Name: "Sausalito Criterium"},
	}
	service.Create(events)

	events = service.Find()

	sort.Sort(ByName(events))

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

	var service EventService
	service.DB = db

	var events = service.Find()
	assert.Equal(t, 2, len(events), "events")
}
