package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestDefaultAndTestCreateDefault(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	var association = as.CreateDefault()

	assert.Equal(t, "CBRA", association.Acronym, "Association acronym")

	association = as.Default()
	assert.Equal(t, "CBRA", association.Acronym, "Default association acronym")
	assert.Equal(t, "Cascadia Bicycle Racing Association", association.Name, "Default association name")
}

func TestDefaultOrCreateDefault(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	var association = as.DefaultOrCreateDefault()

	assert.Equal(t, "CBRA", association.Acronym, "Association acronym")

	association = as.Default()
	assert.Equal(t, "CBRA", association.Acronym, "Default association acronym")

	association = as.DefaultOrCreateDefault()
	assert.Equal(t, "CBRA", association.Acronym, "Default association acronym")
	assert.Equal(t, "Cascadia Bicycle Racing Association", association.Name, "Default association name")

	var count int
	db.Table("associations").Count(&count)
	assert.Equal(t, 1, count)
}

func TestFirstByHost(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	as.CreateDefault()

	atra := api.Association{Acronym: "ATRA", Host: "atra.local"}
	as.Create(&atra)

	var association, err = as.FirstByHost("0.0.0.0")
	assert.NotNil(t, association)
	assert.Equal(t, "CBRA", association.Acronym)
	assert.NoError(t, err)

	association, err = as.FirstByHost("localhost")
	assert.NotNil(t, association)
	assert.Equal(t, "CBRA", association.Acronym)
	assert.NoError(t, err)

	association, err = as.FirstByHost("cbra.web")
	assert.NotNil(t, association)
	assert.Equal(t, "CBRA", association.Acronym)
	assert.NoError(t, err)

	association, err = as.FirstByHost("atra.local")
	assert.NotNil(t, association)
	assert.Equal(t, "ATRA", association.Acronym)
	assert.NoError(t, err)

	association, err = as.FirstByHost("usacycling.org")
	assert.NotNil(t, association)
	assert.Error(t, err)
}

func TestFirstOrCreate(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}

	atra := api.Association{Acronym: "ATRA", Host: "atra.local", Name: "American Track"}
	as.FirstOrCreate(&atra)
	assert.Equal(t, "ATRA", atra.Acronym)
	id := atra.ID
	assert.NotZero(t, id)

	as.FirstOrCreate(&atra)
	assert.Equal(t, "ATRA", atra.Acronym)
	assert.Equal(t, id, atra.ID)

	var count int
	db.Table("associations").Count(&count)
	assert.Equal(t, 1, count)

	wsba := api.Association{Acronym: "WSBA", Host: "wsba.local", Name: "Washington"}
	as.FirstOrCreate(&wsba)
	assert.Equal(t, "WSBA", wsba.Acronym)
	wsbaID := wsba.ID
	assert.NotZero(t, wsbaID)

	as.FirstOrCreate(&wsba)
	assert.Equal(t, "WSBA", wsba.Acronym)
	assert.Equal(t, wsbaID, wsba.ID)

	db.Table("associations").Count(&count)
	assert.Equal(t, 2, count)
}
