package db

import (
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestRailsCopy(t *testing.T) {
	db := Open()
	defer db.Close()

	// TODO encapsulate in test service method
	db.Delete(api.Event{})

	railsDB := OpenRails()
	defer railsDB.Close()

	var eventService EventService
	eventService.DB = db

	var railsService RailsService
	railsService.DB = railsDB
	railsService.EventService = &eventService
	railsService.Copy()

	var events = eventService.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}

func TestRailsFind(t *testing.T) {
	railsDB := OpenRails()
	defer railsDB.Close()

	var railsService RailsService
	railsService.DB = railsDB

	db := Open()
	defer db.Close()

	var eventService EventService
	eventService.DB = db
	railsService.EventService = &eventService

	var events = railsService.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}
