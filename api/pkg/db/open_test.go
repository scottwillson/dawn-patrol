package db

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestOpen(t *testing.T) {
	db := Open()
	defer db.Close()

	assert.NotNil(t, db, "db from db.Open()")
}

func TestOpenURL(t *testing.T) {
	db := OpenURL("postgres://dawnpatrol@db-dev/dawnpatrol_test?sslmode=disable")
	defer db.Close()

	assert.NotNil(t, db, "db from db.OpenURL()")
}

func TestOpenURLPanicsOnBogusURL(t *testing.T) {
	assert.Panics(t, func() { OpenURL("*** bogus ***") })
}

func TestDefaultDatabaseURL(t *testing.T) {
	originalDatabaseURL := os.Getenv("DATABASE_URL")
	defer func() { os.Setenv("DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("DATABASE_URL", "")
	assert.Equal(t, "postgres://dawnpatrol@db/dawnpatrol_development?sslmode=disable", databaseURL(), "db.databaseURL()")
}

func TestDatabaseURLFromEnv(t *testing.T) {
	originalDatabaseURL := os.Getenv("DATABASE_URL")
	defer func() { os.Setenv("DATABASE_URL", originalDatabaseURL) }()

	os.Setenv("DATABASE_URL", "postgres://test-db")
	assert.Equal(t, "postgres://test-db", databaseURL(), "db.databaseURL()")
}

func TestDatabaseDriverForMysql(t *testing.T) {
	assert := assert.New(t)

	driver, err := databaseDriver("rails:rails@tcp(rails-db:3306)/rails")
	assert.Nil(err, "db.databaseDriver() for mysql")
	assert.Equal("mysql", driver, "db.databaseDriver() for mysql")
}

func TestDatabaseDriverForPostgres(t *testing.T) {
	assert := assert.New(t)

	driver, err := databaseDriver("postgres://dawnpatrol@db/dawnpatrol_test")
	assert.Nil(err, "db.databaseDriver() for postgres")
	assert.Equal("postgres", driver, "db.databaseDriver() for postgres")
}

func TestUnkownDatabaseDriver(t *testing.T) {
	assert := assert.New(t)

	driver, err := databaseDriver("no url!")
	assert.NotNil(err, "err for unknown URL")
	assert.Equal("", driver, "driver for unknown URL")
}
