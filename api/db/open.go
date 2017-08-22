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
	var err error
	var db *gorm.DB
	driver := databaseDriver(url)

	for attempts := 0; attempts < 10; attempts++ {
		if db, err = gorm.Open(driver, url); err == nil && db != nil {
			return db
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	panic("Could not connect to " + driver + ", " + url + ". " + err.Error())
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
	} else if strings.HasPrefix(url, "rails") {
		return "mysql"
	} else {
		panic("Could not find driver for " + url)
	}
}
