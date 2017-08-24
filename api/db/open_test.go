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

func TestDatabaseDriver(t *testing.T) {
	assert := assert.New(t)
	assert.Equal("postgres", databaseDriver("postgres://dawnpatrol@db/dawnpatrol_test"), "db.databaseDriver() for postgres")
	assert.Equal("mysql", databaseDriver("rails:rails@tcp(rails-db:3306)/rails"), "db.databaseDriver() for mysql")
}
