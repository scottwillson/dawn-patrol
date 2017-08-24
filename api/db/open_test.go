package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestOpen(t *testing.T) {
	db := Open()
	defer db.Close()

	assert.NotNil(t, db, "db from db.Open()")
}

func TestOpenURL(t *testing.T) {
	db := OpenURL("postgres://dawnpatrol@db/dawnpatrol_development?sslmode=disable")
	defer db.Close()

	assert.NotNil(t, db, "db from db.OpenURL()")
}

func TestDatabaseURL(t *testing.T) {
	assert.NotNil(t, databaseURL(), "db.databaseURL()")
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
