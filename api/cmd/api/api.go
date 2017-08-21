package main

import (
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"rocketsurgeryllc.com/dawnpatrol/api/db"
	"rocketsurgeryllc.com/dawnpatrol/api/http"
)

func main() {
	postgres := db.Open()
	defer postgres.Close()

	var es db.EventService
	es.DB = postgres

	railsDB := db.OpenRails()
	defer railsDB.Close()

	var rails db.RailsService
	rails.DB = railsDB
	rails.EventService = &es

	mux := http.NewMux(es, rails)
	http.ListenAndServe(mux)
}
