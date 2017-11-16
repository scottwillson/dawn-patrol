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

	association := as.CreateDefault()

	assert := assert.New(t)
	var count int
	db.Table("associations").Count(&count)
	assert.Equal(1, count)
	assert.NotZero(association.ID)

	es := EventService{DB: db, Logger: &logger}

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race", AssociationID: association.ID},
		api.Event{Name: "Sausalito Criterium", AssociationID: association.ID},
	}
	es.Create(events)

	db.Table("associations").Count(&count)
	assert.Equal(1, count)

	var err error
	events, err = es.Find(&association)
	if err != nil {
		assert.FailNow("Could not find events", err.Error())
	}

	sort.Sort(api.ByName(events))

	assert.Equal(2, len(events), "events")
	assert.Equal("Copperopolis Road Race", events[0].Name, "event name")
	assert.Equal("Sausalito Criterium", events[1].Name, "event name")
}

func TestFind(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	cbra := api.Association{Acronym: "CBRA", Name: "CBRA", Host: "cbra.web"}
	db.Create(&cbra)

	mbra := api.Association{Acronym: "MBRA", Name: "MBRA", Host: "mbra.web"}
	db.Create(&mbra)

	db.Create(&api.Event{AssociationID: mbra.ID})
	db.Create(&api.Event{AssociationID: cbra.ID})
	db.Create(&api.Event{AssociationID: cbra.ID})

	es := EventService{DB: db, Logger: &logger}

	var events, err = es.Find(&cbra)
	if err != nil {
		assert.FailNow(t, "Could not find events", err.Error())
	}

	assert.Equal(t, 2, len(events), "events")
}
