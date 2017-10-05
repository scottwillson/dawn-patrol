package db

import (
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestCreate(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Delete(api.Event{})

	es := EventService{DB: db, Logger: &logger}

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race"},
		api.Event{Name: "Sausalito Criterium"},
	}
	es.Create(events)

	events = es.Find("cbra")

	sort.Sort(api.ByName(events))

	assert := assert.New(t)
	assert.Equal(2, len(events), "events")
	assert.Equal("Copperopolis Road Race", events[0].Name, "event name")
	assert.Equal("Sausalito Criterium", events[1].Name, "event name")
}

func TestFind(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Delete(&api.Association{})
	association := api.Association{Acronym: "cbra"}
	db.Create(&association)

	db.Delete(&api.Event{})
	db.Create(&api.Event{Association: association})
	db.Create(&api.Event{Association: association})

	es := EventService{DB: db, Logger: &logger}

	var events = es.Find("cbra")
	assert.Equal(t, 2, len(events), "events")

	assert.Panics(t, func() { es.Find("") }, "requires association")
}
