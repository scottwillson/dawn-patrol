package main

import (
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"rocketsurgeryllc.com/dawnpatrol/api/db"
	http "rocketsurgeryllc.com/dawnpatrol/api/http"
)

func main() {
	postgres, err := openDb()
	if err != nil {
		panic(err)
	}
	defer postgres.Close()

	var es db.EventService
	es.DB = postgres

	railsDB, err := openRailsDb()
	if err != nil {
		panic(err)
	}
	defer railsDB.Close()

	var rails db.RailsService
	rails.DB = railsDB
	rails.EventService = &es

	mux := http.NewMux(es, rails)
	http.ListenAndServe(mux)
}

func openDb() (*gorm.DB, error) {
	var conn *gorm.DB
	var err error
	for attempts := 0; attempts < 11; attempts++ {
		conn, err = gorm.Open("postgres", databaseURL())
		if err == nil && conn != nil {
			return conn, nil
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	return nil, err
}

func databaseURL() string {
	databaseURL := os.Getenv("DATABASE_URL")
	if databaseURL == "" {
		return "postgres://dawnpatrol@db/dawnpatrol_development?sslmode=disable"
	}
	return databaseURL
}

func openRailsDb() (*gorm.DB, error) {
	var conn *gorm.DB
	var err error
	for attempts := 0; attempts < 11; attempts++ {
		conn, err = gorm.Open("mysql", "rails:rails@tcp(rails:3306)/rails")
		if err == nil && conn != nil {
			return conn, nil
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	return nil, err
}
