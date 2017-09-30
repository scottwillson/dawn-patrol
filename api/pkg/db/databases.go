package db

import (
	"fmt"
	"math"
	"os"
	"strings"
	"time"

	"github.com/go-kit/kit/log"
	// Gorm requirement
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	// Gorm requirement
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

// Databases is a factory for DB connections
type Databases struct {
	Logger log.Logger
}

// Default returns a connection to the default Dawn Patrol Postgres DB
func (d Databases) Default() *gorm.DB {
	return d.For("")
}

// For returns a connection to the MySQL database for the association
func (d Databases) For(association string) *gorm.DB {
	url := databaseURL(association)
	if d.Logger != nil {
		d.Logger.Log("action", "open", "url", url)
	}

	db := openURL(url)
	d.Logger.Log("action", "opened", "url", url)

	return db
}

func databaseURL(association string) string {
	if association == "" {
		databaseURL := os.Getenv("DATABASE_URL")
		if databaseURL == "" {
			return "postgres://dawnpatrol@db/dawnpatrol_development?sslmode=disable"
		}
		return databaseURL
	}
	key := fmt.Sprintf("%s_URL", strings.ToUpper(association))
	databaseURL := os.Getenv(key)
	if databaseURL == "" {
		return fmt.Sprintf("%s:rails@tcp(rails-db:3306)/%s?parseTime=True", association, association)
	}
	return databaseURL
}

func openURL(url string) *gorm.DB {
	return openURLWithAttempts(url, 10)
}

func openURLWithAttempts(url string, attempts int) *gorm.DB {
	var db *gorm.DB
	var err error

	driver := databaseDriver(url)

	for a := 0; a < attempts; a++ {
		if db, err = gorm.Open(driver, url); err == nil && db != nil {
			return db
		}
		fmt.Println(err)
		seconds := time.Duration(math.Pow(1.5, float64(a))) * time.Second
		time.Sleep(seconds)
	}

	panic("Could not connect to " + driver + ", " + url + ". " + err.Error())
}

func databaseDriver(url string) string {
	if strings.HasPrefix(url, "postgres") {
		return "postgres"
	}
	return "mysql"
}
