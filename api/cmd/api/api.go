package main

import (
	"os"
	"time"

	"github.com/jinzhu/gorm"
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

	var rails db.RailsService

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
