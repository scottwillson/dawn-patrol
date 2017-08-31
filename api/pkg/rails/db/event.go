package db

import (
	"os"

	"github.com/go-kit/kit/log"
	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// EventService implements api.rails.EventService.
type EventService struct {
	APIEventService api.EventService
	DB              *gorm.DB
	Logger          log.Logger
}

// Copy copies events from Racing on Rails MySQL DB to Dawn Patrol DB.
func (s *EventService) Copy() {
	s.Logger.Log("action", "copy")

	var railsEvents []rails.Event
	s.DB.Find(&railsEvents)

	events := make([]api.Event, len(railsEvents))
	for i, e := range railsEvents {
		events[i] = api.Event{Name: e.Name}
	}

	s.APIEventService.Create(events)
}

// Find finds all events in the Racing on Rails MySQL DB.
func (s *EventService) Find() []rails.Event {
	s.Logger.Log("action", "find")

	var events []rails.Event
	s.DB.Find(&events)
	return events
}

// Open opens a connection to the Rails MySQL DB.
func Open() *gorm.DB {
	return db.OpenURL(railsDatabaseURL())
}

func railsDatabaseURL() string {
	databaseURL := os.Getenv("RAILS_DATABASE_URL")
	if databaseURL == "" {
		return "rails:rails@tcp(rails-db:3306)/rails"
	}
	return databaseURL
}
