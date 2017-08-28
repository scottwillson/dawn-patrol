package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api"
	"rocketsurgeryllc.com/dawnpatrol/api/db"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestRailsCopy(t *testing.T) {
	dpDB := db.Open()
	defer dpDB.Close()

	dpDB.Delete(api.Event{})

	railsDB := Open()
	defer railsDB.Close()

	eventService := &db.EventService{DB: dpDB}

	railsService := &EventService{DB: railsDB, APIEventService: eventService}
	railsService.Copy()

	events := eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}

func TestRailsFind(t *testing.T) {
	dpDB := Open()
	defer dpDB.Close()

	var eventService EventService
	eventService.DB = dpDB

	var events = eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}
