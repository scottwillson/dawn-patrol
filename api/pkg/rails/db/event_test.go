package db

import (
	"sort"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"

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

	eventService := &db.EventService{DB: dpDB, Logger: &log.MockLogger{}}

	railsService := &EventService{DB: railsDB, APIEventService: eventService, Logger: &log.MockLogger{}}
	if err := railsService.Copy(); err != nil {
		t.Error(err)
	}

	events := eventService.Find()
	sort.Sort(api.ByName(events))

	assert := assert.New(t)
	assert.Equal(2, len(events), "events")

	// promoter_id, type, created_at, updated_at
	pacific, err := time.LoadLocation("America/Los_Angeles")
	if err != nil {
		t.Error(err)
	}

	assert.Equal("AVC", events[0].Name, "event name")
	assert.Equal("Portland", events[0].City, "event city")
	dateInPacific := time.Date(2009, 7, 10, 0, 0, 0, 0, pacific)
	if !dateInPacific.Equal(events[0].StartsAt) {
		t.Errorf("ToAssociationTimeZone should convert time %v to association time zone %v", events[0].StartsAt, dateInPacific)
	}
	assert.Equal("Track", events[0].Discipline, "event discipline")
	assert.Equal(2, events[0].RailsID, "event Rails ID")
	assert.Equal("OR", events[0].State, "event State")
	railsCreatedAt := time.Date(2009, 7, 10, 18, 35, 0, 0, time.UTC)
	if !railsCreatedAt.Equal(events[0].RailsCreatedAt) {
		t.Errorf("expected railsCreatedAt %v to be %v", railsCreatedAt, events[0].RailsCreatedAt)
	}
	railsUpdatedAt := time.Date(2009, 7, 8, 18, 0, 1, 0, time.UTC)
	if !railsUpdatedAt.Equal(events[0].RailsUpdatedAt) {
		t.Errorf("expected RailsUpdatedAt %v to be %v", railsUpdatedAt, events[0].RailsUpdatedAt)
	}

	assert.Equal("Hellyer Challenge", events[1].Name, "event name")
	assert.Equal("San Jose", events[1].City, "event city")
	dateInPacific = time.Date(2009, 7, 3, 0, 0, 0, 0, pacific)
	if !dateInPacific.Equal(events[1].StartsAt) {
		t.Errorf("ToAssociationTimeZone should convert time %v to association time zone %v", events[1].StartsAt, dateInPacific)
	}
	assert.Equal("Track", events[1].Discipline, "event discipline")
	assert.Equal(1, events[1].RailsID, "event Rails ID")
	assert.Equal("CA", events[1].State, "event State")
	railsCreatedAt = time.Date(2009, 7, 10, 18, 34, 0, 0, time.UTC)
	if !railsCreatedAt.Equal(events[1].RailsCreatedAt) {
		t.Errorf("expected railsCreatedAt %v to be %v", railsCreatedAt, events[0].RailsCreatedAt)
	}
	railsUpdatedAt = time.Date(2009, 7, 10, 18, 34, 0, 0, time.UTC)
	if !railsUpdatedAt.Equal(events[1].RailsUpdatedAt) {
		t.Errorf("expected RailsUpdatedAt %v to be %v", railsUpdatedAt, events[0].RailsUpdatedAt)
	}
}

func TestToAssociationTimeZone(t *testing.T) {
	utcDate := time.Date(2009, 7, 3, 0, 0, 0, 0, time.UTC)

	assocDate, err := ToAssociationTimeZone(utcDate)
	if err != nil {
		t.Error(err)
	}

	pacific, err := time.LoadLocation("America/Los_Angeles")
	if err != nil {
		t.Error(err)
	}

	dateInPacific := time.Date(2009, 7, 3, 0, 0, 0, 0, pacific)
	if !dateInPacific.Equal(assocDate) {
		t.Errorf("ToAssociationTimeZone should convert time %v to association time zone %v", assocDate, dateInPacific)
	}
}

func TestRailsFind(t *testing.T) {
	dpDB := Open()
	defer dpDB.Close()

	eventService := &db.EventService{DB: dpDB, Logger: &log.MockLogger{}}

	var events = eventService.Find()

	assert.Equal(t, 2, len(events), "events")
}
