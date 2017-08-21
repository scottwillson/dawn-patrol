package db

import (
	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api"
)

// RailsService implements api.RailsService
type RailsService struct {
	DB           *gorm.DB
	EventService *EventService
}

// Copy from Racing on Rails MySQL DB
func (s RailsService) Copy() bool {
	var railsEvents []api.RailsEvent
	s.DB.Find(&railsEvents)

	events := make([]api.Event, len(railsEvents))
	for i, event := range railsEvents {
		events[i] = api.Event{Name: event.Name}
	}

	s.EventService.Create(events)

	return true
}

// Find all events in the Racing on Rails MySQL DB
func (s RailsService) Find() []api.RailsEvent {
	var events []api.RailsEvent
	s.DB.Find(&events)
	return events
}
