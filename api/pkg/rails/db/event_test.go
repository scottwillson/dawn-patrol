package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"

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

	eventService := &db.EventService{DB: dpDB, Logger: &api.MockLogger{}}

	railsService := &EventService{DB: railsDB, APIEventService: eventService, Logger: &api.MockLogger{}}
	railsService.Copy()

	events := eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}

func TestRailsFind(t *testing.T) {
	dpDB := Open()
	defer dpDB.Close()

	eventService := &db.EventService{DB: dpDB, Logger: &api.MockLogger{}}

	var events = eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}
