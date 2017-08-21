package db

import (
	"os"
	"strings"
	"time"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func Open() *gorm.DB {
	return open(databaseURL())
}

func open(url string) *gorm.DB {
	var db *gorm.DB
	var err error
	for attempts := 0; attempts < 4; attempts++ {
		if db, err = gorm.Open("postgres", url); err == nil && db != nil {
			return db
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	// panic("Could not connect to " + url)
	panic("Could not connect to " + url + ". " + err.Error())
}

func databaseURL() string {
	databaseURL := os.Getenv("DATABASE_URL")
	if databaseURL == "" {
		return "postgres://dawnpatrol@db/dawnpatrol_development?sslmode=disable"
	}
	return databaseURL
}

func databaseDriver(url string) string {
	if strings.HasPrefix(url, "postgres") {
		return "postgres"
	} else if strings.HasPrefix(url, "mysql") {
		return "mysql"
	} else {
		panic("Did not recogonize driver in " + url)
	}
}
