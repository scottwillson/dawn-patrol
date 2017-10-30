package db

import (
	"os"
	"sort"
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

func TestFor(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.For("rails")
	defer db.Close()

	var events []rails.Event
	db.Find(&events)
}

func TestDefault(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Delete(api.Association{})
	db.Delete(api.Event{})

	as := AssociationService{DB: db, Logger: &logger}
	as.CreateDefault()

	es := EventService{DB: db, Logger: &logger}

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race"},
		api.Event{Name: "Sausalito Criterium"},
	}
	es.Create(events)

	var err error
	events, err = es.Find("cbra")
	if err != nil {
		assert.FailNow(t, "Could not find events", err.Error())
	}

	sort.Sort(api.ByName(events))

	assert := assert.New(t)
	assert.Equal(2, len(events), "events")
	assert.Equal("Copperopolis Road Race", events[0].Name, "event name")
	assert.Equal("Sausalito Criterium", events[1].Name, "event name")
}

func TestOpenURL(t *testing.T) {
	db := openURL("postgres://dawnpatrol@db-dev/dawnpatrol_test?sslmode=disable")
	defer db.Close()

	assert.NotNil(t, db, "db from db.OpenURL()")
}

func TestOpenURLPanicsOnBogusURL(t *testing.T) {
	assert.Panics(t, func() { openURLWithAttempts("*** bogus ***", 2) })
}

func TestDefaultDatabaseURL(t *testing.T) {
	originalDatabaseURL := os.Getenv("DATABASE_URL")
	defer func() { os.Setenv("DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("DATABASE_URL", "")
	assert.Equal(t, "postgres://dawnpatrol@db/dawnpatrol_development?sslmode=disable", databaseURL(""), "db.databaseURL()")
}

func TestDatabaseURLFromEnv(t *testing.T) {
	originalDatabaseURL := os.Getenv("DATABASE_URL")
	defer func() { os.Setenv("DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("DATABASE_URL", "postgres://test-db")
	assert.Equal(t, "postgres://test-db", databaseURL(""), "db.databaseURL()")
}

func TestDatabaseURLForRails(t *testing.T) {
	originalDatabaseURL := os.Getenv("RAILS_DATABASE_URL")
	defer func() { os.Setenv("RAILS_DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("RAILS_DATABASE_URL", "mysql://rails-db")
	assert.Equal(t, "mysql://rails-db", databaseURL("rails"), "db.databaseURL('rails')")
}

func TestDatabaseDriverForMysql(t *testing.T) {
	assert := assert.New(t)

	driver := databaseDriver("rails:rails@tcp(rails-db:3306)/rails?parseTime=True")
	assert.Equal("mysql", driver, "db.databaseDriver() for mysql")
}

func TestDatabaseDriverForPostgres(t *testing.T) {
	assert := assert.New(t)

	driver := databaseDriver("postgres://dawnpatrol@db/dawnpatrol_test")
	assert.Equal("postgres", driver, "db.databaseDriver() for postgres")
}
