package db

import (
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestCreateEvents(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}

	association := as.CreateDefaultAssociation()

	es := EventService{DB: db, Logger: &logger}

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race", Association: association},
		api.Event{Name: "Sausalito Criterium", Association: association},
	}
	es.Create(events)

	var err error
	events, err = es.Find("CBRA")
	if err != nil {
		assert.FailNow(t, "Could not find events", err.Error())
	}

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

	db.Unscoped().Delete(&api.Association{})
	association := api.Association{Acronym: "CBRA", Name: "Cascadia Bicycle Racing Association"}
	db.Create(&association)

	db.Unscoped().Delete(&api.Event{})
	db.Create(&api.Event{Association: association})
	db.Create(&api.Event{Association: association})

	es := EventService{DB: db, Logger: &logger}

	var events, err = es.Find("CBRA")
	if err != nil {
		assert.FailNow(t, "Could not find events", err.Error())
	}

	assert.Equal(t, 2, len(events), "events")

	events, err = es.Find("")
	assert.Equal(t, 0, len(events), "events")
	assert.NotNil(t, err, "Find() requires association")

	events, err = es.Find("xbi")
	assert.Equal(t, 0, len(events), "events")
	assert.NotNil(t, err, "Find() requires association")
}
