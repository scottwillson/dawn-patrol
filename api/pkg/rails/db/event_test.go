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
	logger := log.MockLogger{}
	dbs := db.Databases{Logger: &logger}

	dpDB := dbs.Default()
	defer dpDB.Close()

	eventService := &db.EventService{DB: dpDB, Logger: &logger}
	railsService := &EventService{Databases: dbs, APIEventService: eventService, Logger: &logger}

	dpDB.Delete(api.Event{})

	events, err := eventService.Find("CBRA")
	if err != nil {
		t.Error(err)
	}
	assert := assert.New(t)
	assert.Equal(0, len(events), "events")

	railsEvents := railsService.Find("rails")
	assert.Equal(2, len(railsEvents), "Rails events")

	if err := railsService.Copy("rails"); err != nil {
		t.Error(err)
	}

	events, err = eventService.Find("CBRA")
	if err != nil {
		t.Error(err)
	}
	assert.Equal(2, len(events), "events")

	// promoter_id, type, created_at, updated_at
	pacific, err := time.LoadLocation("America/Los_Angeles")
	if err != nil {
		t.Error(err)
	}

	sort.Sort(api.ByName(events))
	assert.Equal("AVC", events[0].Name, "event name")
	assert.Equal("Portland", events[0].City, "event city")
	dateInPacific := time.Date(2009, 7, 10, 0, 0, 0, 0, pacific)
	if !dateInPacific.Equal(events[0].StartsAt) {
		t.Errorf("ToAssociationTimeZone should convert time %v to association time zone %v", events[0].StartsAt, dateInPacific)
	}
	assert.Equal("Track", events[0].Discipline, "event discipline")
	assert.Equal(2, events[0].RailsID, "event Rails ID")
	assert.Equal("OR", events[0].State, "event State")
	railsCreatedAt := time.Date(2009, 1, 7, 11, 35, 0, 0, time.UTC)
	if !railsCreatedAt.Equal(events[0].RailsCreatedAt) {
		t.Errorf("expected railsCreatedAt %v to be %v", events[0].RailsCreatedAt, railsCreatedAt)
	}
	railsUpdatedAt := time.Date(2009, 1, 9, 2, 0, 1, 0, time.UTC)
	if !railsUpdatedAt.Equal(events[0].RailsUpdatedAt) {
		t.Errorf("expected RailsUpdatedAt %v to be %v", events[0].RailsUpdatedAt, railsUpdatedAt)
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
	railsCreatedAt = time.Date(2009, 1, 7, 11, 34, 0, 0, time.UTC)
	if !railsCreatedAt.Equal(events[1].RailsCreatedAt) {
		t.Errorf("expected railsCreatedAt %v to be %v", events[0].RailsCreatedAt, railsCreatedAt)
	}
	railsUpdatedAt = time.Date(2009, 1, 7, 11, 34, 0, 0, time.UTC)
	if !railsUpdatedAt.Equal(events[1].RailsUpdatedAt) {
		t.Errorf("expected RailsUpdatedAt %v to be %v", events[0].RailsUpdatedAt, railsUpdatedAt)
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
	logger := log.MockLogger{}
	dbs := db.Databases{Logger: &logger}

	eventService := &EventService{Databases: dbs, Logger: &logger}

	var events = eventService.Find("rails")

	assert.Equal(t, 2, len(events), "events")
}
