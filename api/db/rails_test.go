package db

import (
	"errors"
	"testing"
	"time"

	"rocketsurgeryllc.com/dawnpatrol/api"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestRailsCopy(t *testing.T) {
	db, err := openDb()
	if err != nil {
		panic(err)
	}
	defer db.Close()

	// TODO encapsulate in test service method
	db.Delete(api.Event{})

	railsDB, err := openRails()
	if err != nil {
		panic(err)
	}
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
	railsDB, err := openRails()
	if err != nil {
		panic(err)
	}
	defer railsDB.Close()

	var railsService RailsService
	railsService.DB = railsDB

	db, err := openDb()
	if err != nil {
		panic(err)
	}
	defer db.Close()

	var eventService EventService
	eventService.DB = db
	railsService.EventService = &eventService

	var events = railsService.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}

// Open Rails MySQL DB conn
func openRails() (*gorm.DB, error) {
	for attempts := 0; attempts < 10; attempts++ {
		if db, err := gorm.Open("mysql", "rails:rails@tcp(rails:3306)/rails"); err == nil && db != nil {
			return db, nil
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	return nil, errors.New("Could not connect to database")
}
