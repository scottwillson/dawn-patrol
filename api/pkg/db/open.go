package db

import (
	"errors"
	"math"
	"os"
	"strings"
	"time"

	"github.com/go-kit/kit/log"
	"github.com/jinzhu/gorm"
	// Required for Gorm.
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

// Open opens DB connection to databaseURL().
func Open(logger log.Logger) *gorm.DB {
	url := databaseURL()
	if logger != nil {
		logger.Log("action", "open", "url", url)
	}
	return OpenURL(url)
}

// OpenURL opens a DB connection to URL.
func OpenURL(url string) *gorm.DB {
	var db *gorm.DB
	var driver string
	var err error

	if driver, err = databaseDriver(url); err != nil {
		panic(err)
	}

	for a := 0; a < 10; a++ {
		if db, err = gorm.Open(driver, url); err == nil && db != nil {
			return db
		}
		seconds := time.Duration(math.Pow(1.5, float64(a))) * time.Second
		time.Sleep(seconds)
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

func databaseDriver(url string) (string, error) {
	if strings.HasPrefix(url, "postgres") {
		return "postgres", nil
	} else if strings.HasPrefix(url, "rails") {
		return "mysql", nil
	} else {
		return "", errors.New("Could not find driver for " + url)
	}
}
