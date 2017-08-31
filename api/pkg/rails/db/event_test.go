package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/mock"

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

	eventService := &db.EventService{DB: dpDB, Logger: &mock.Logger{}}

	railsService := &EventService{DB: railsDB, APIEventService: eventService, Logger: &mock.Logger{}}
	railsService.Copy()

	events := eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}

func TestRailsFind(t *testing.T) {
	dpDB := Open()
	defer dpDB.Close()

	eventService := &db.EventService{DB: dpDB, Logger: &mock.Logger{}}

	var events = eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}
