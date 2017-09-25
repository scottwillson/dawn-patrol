package db

import (
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestFor(t *testing.T) {
	t.FailNow()
}

func TestDefault(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Delete(api.Event{})

	es := EventService{Databases: dbs, Logger: &logger}

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
