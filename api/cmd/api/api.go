package main

import (
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"rocketsurgeryllc.com/dawnpatrol/api/db"
	"rocketsurgeryllc.com/dawnpatrol/api/http"
	railsDB "rocketsurgeryllc.com/dawnpatrol/api/rails/db"
)

func main() {
	postgres := db.Open()
	defer postgres.Close()

	es := &db.EventService{DB: postgres}

	mysql := railsDB.Open()
	defer mysql.Close()

	rails := &railsDB.EventService{DB: mysql, ApiEventService: es}

	mux := http.NewMux(es, rails)
	http.ListenAndServe(mux)
}
