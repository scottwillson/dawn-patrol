package db

import (
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api"
	apiDB "rocketsurgeryllc.com/dawnpatrol/api/db"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestRailsCopy(t *testing.T) {
	db := apiDB.Open()
	defer db.Close()

	// TODO encapsulate in test service method
	db.Delete(api.Event{})

	railsDB := Open()
	defer railsDB.Close()

	eventService := &apiDB.EventService{DB: db}

	railsService := &EventService{DB: railsDB, ApiEventService: eventService}
	railsService.Copy()

	var events = eventService.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}

func TestRailsFind(t *testing.T) {
	db := Open()
	defer db.Close()

	var eventService EventService
	eventService.DB = db

	var events = eventService.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}
