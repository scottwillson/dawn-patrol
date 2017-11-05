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

func TestFirstAcronymByHost(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	as.CreateDefaultAssociation()

	atra := api.Association{Acronym: "ATRA", Host: "atra.local"}
	as.CreateAssociation(atra)

	var acronym = as.FirstAcronymByHost("0.0.0.0")
	assert.Equal(t, "CBRA", acronym)

	acronym = as.FirstAcronymByHost("localhost")
	assert.Equal(t, "CBRA", acronym)

	acronym = as.FirstAcronymByHost("cbra.local")
	assert.Equal(t, "CBRA", acronym)

	acronym = as.FirstAcronymByHost("atra.local")
	assert.Equal(t, "ATRA", acronym)
}

func TestFirstOrCreate(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Unscoped().Delete(&api.Association{})

	var association = api.Association{Acronym: "ATRA", Host: "atra.local"}
	as := AssociationService{DB: db, Logger: &logger}

	association = as.FirstOrCreate(association)
	assert.Equal(t, "ATRA", association.Acronym)

	association = as.FirstOrCreate(association)
	assert.Equal(t, "ATRA", association.Acronym)

	var count int
	db.Table("associations").Count(&count)
	assert.Equal(t, 1, count)
}
