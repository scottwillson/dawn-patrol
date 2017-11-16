package db

import (
	"os"
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"

	"github.com/stretchr/testify/assert"
)

func TestFor(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.For("CBRA")
	defer db.Close()

	var events []rails.Event
	db.Find(&events)
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
	originalDatabaseURL := os.Getenv("CBRA_DATABASE_URL")
	defer func() { os.Setenv("CBRA_DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("CBRA_DATABASE_URL", "mysql://rails-db")
	assert.Equal(t, "mysql://rails-db", databaseURL("CBRA"), "db.databaseURL('CBRA')")
}

func TestDatabaseURLForDevRails(t *testing.T) {
	originalDatabaseURL := os.Getenv("ATRA_DATABASE_URL")
	defer func() { os.Setenv("ATRA_DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("ATRA_DATABASE_URL", "mysql://rails-db")
	assert.Equal(t, "mysql://rails-db", databaseURL("atra"), "db.databaseURL('atra')")
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
