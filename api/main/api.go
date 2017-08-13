package main

import (
	"os"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"rocketsurgeryllc.com/dawnpatrol/api/db"
	http "rocketsurgeryllc.com/dawnpatrol/api/http"
)

func main() {
	postgres, err := gorm.Open("postgres", databaseURL())
	if err != nil {
		panic(err)
	}
	defer postgres.Close()

	var es db.EventService
	es.DB = postgres

	mux := http.NewMux(&es)
	http.ListenAndServe(mux)
}

func databaseURL() string {
	databaseURL := os.Getenv("DATABASE_URL")
	if databaseURL == "" {
		return "postgres://dawnpatrol@db/dawnpatrol?sslmode=disable"
	}
	return databaseURL
}
