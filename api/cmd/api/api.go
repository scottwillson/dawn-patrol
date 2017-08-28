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
	dpDB := db.Open()
	defer dpDB.Close()

	es := &db.EventService{DB: dpDB}

	mysql := railsDB.Open()
	defer mysql.Close()

	railsES := &railsDB.EventService{DB: mysql, APIEventService: es}

	mux := http.NewMux(es, railsES)
	http.ListenAndServe(mux)
}
