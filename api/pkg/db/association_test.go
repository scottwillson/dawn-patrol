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

	db.Delete(&api.Event{})
	db.Delete(&api.Association{})

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

	db.Delete(&api.Event{})
	db.Delete(&api.Association{})

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
	_, db, logger, assert := SetupTest(t)
	defer db.Close()

	as := AssociationService{DB: db, Logger: logger}

	atra := api.Association{Acronym: "ATRA", Host: "atra.local"}
	as.Create(&atra)

	var association, err = as.FirstByHost("0.0.0.0")
	assert.NotNil(association)
	assert.Equal("CBRA", association.Acronym)
	assert.NoError(err)

	association, err = as.FirstByHost("localhost")
	assert.NotNil(association)
	assert.Equal("CBRA", association.Acronym)
	assert.NoError(err)

	association, err = as.FirstByHost("cbra.web")
	assert.NotNil(association)
	assert.Equal("CBRA", association.Acronym)
	assert.NoError(err)

	association, err = as.FirstByHost("cbra.web:8080")
	assert.NotNil(association)
	assert.Equal("CBRA", association.Acronym)
	assert.NoError(err)

	association, err = as.FirstByHost("atra.local")
	assert.NotNil(association)
	assert.Equal("ATRA", association.Acronym)
	assert.NoError(err)

	association, err = as.FirstByHost("usacycling.org")
	assert.NotNil(association)
	assert.Error(err)

	subdomainHost := api.Association{Acronym: "SUB", Host: "^sub.|subdomain.org", Name: "Subdomain Association"}
	as.Create(&subdomainHost)
	association, err = as.FirstByHost("sub.racingonrails.com")
	assert.NotNil(association)
	assert.Equal("SUB", association.Acronym)
	assert.NoError(err)
}

func TestFirstOrCreate(t *testing.T) {
	_, db, logger, assert := SetupTest(t)
	defer db.Close()

	as := AssociationService{DB: db, Logger: logger}

	var count int
	db.Table("associations").Count(&count)
	assert.Equal(1, count)

	atra := api.Association{Acronym: "ATRA", Host: "atra.local", Name: "American Track"}
	as.FirstOrCreate(&atra)
	assert.Equal("ATRA", atra.Acronym)
	id := atra.ID
	assert.NotZero(id)

	as.FirstOrCreate(&atra)
	assert.Equal("ATRA", atra.Acronym)
	assert.Equal(id, atra.ID)

	db.Table("associations").Count(&count)
	assert.Equal(2, count)

	wsba := api.Association{Acronym: "WSBA", Host: "wsba.local", Name: "Washington"}
	as.FirstOrCreate(&wsba)
	assert.Equal("WSBA", wsba.Acronym)
	wsbaID := wsba.ID
	assert.NotZero(wsbaID)

	as.FirstOrCreate(&wsba)
	assert.Equal("WSBA", wsba.Acronym)
	assert.Equal(wsbaID, wsba.ID)

	db.Table("associations").Count(&count)
	assert.Equal(3, count)
}
