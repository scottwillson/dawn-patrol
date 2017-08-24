package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api"
	apiDB "rocketsurgeryllc.com/dawnpatrol/api/db"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestRailsCopy(t *testing.T) {
	db := apiDB.Open()
	defer db.Close()

	db.Delete(api.Event{})

	railsDB := Open()
	defer railsDB.Close()

	eventService := &apiDB.EventService{DB: db}

	railsService := &EventService{DB: railsDB, APIEventService: eventService}
	railsService.Copy()

	var events = eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}

func TestRailsFind(t *testing.T) {
	db := Open()
	defer db.Close()

	var eventService EventService
	eventService.DB = db

	var events = eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}
