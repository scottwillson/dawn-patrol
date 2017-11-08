package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestDefaultAndTestCreateDefaultAssociation(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	var association = as.CreateDefaultAssociation()

	assert.Equal(t, "CBRA", association.Acronym, "Association acronym")

	association = as.Default()
	assert.Equal(t, "CBRA", association.Acronym, "Default association acronym")
	assert.Equal(t, "Cascadia Bicycle Racing Association", association.Name, "Default association name")
}

func TestDefaultOrCreateDefaultAssociation(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	var association = as.DefaultOrCreateDefaultAssociation()

	assert.Equal(t, "CBRA", association.Acronym, "Association acronym")

	association = as.Default()
	assert.Equal(t, "CBRA", association.Acronym, "Default association acronym")

	association = as.DefaultOrCreateDefaultAssociation()
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
	as.CreateDefaultAssociation()

	atra := api.Association{Acronym: "ATRA", Host: "atra.local"}
	as.CreateAssociation(&atra)

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

	var association = api.Association{Acronym: "ATRA", Host: "atra.local"}
	as := AssociationService{DB: db, Logger: &logger}

	as.FirstOrCreate(&association)
	assert.Equal(t, "ATRA", association.Acronym)
	id := association.ID
	assert.NotZero(t, id)

	as.FirstOrCreate(&association)
	assert.Equal(t, "ATRA", association.Acronym)
	assert.Equal(t, id, association.ID)

	var count int
	db.Table("associations").Count(&count)
	assert.Equal(t, 1, count)
}
