package db

import (
	"github.com/go-kit/kit/log"

	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
)

// EventService implements api.EventService.
type EventService struct {
	DB     *gorm.DB
	Logger log.Logger
}

// Create creates api.Events.
func (s *EventService) Create(events []api.Event) {
	s.Logger.Log("action", "create")
	for _, event := range events {
		s.DB.Create(event)
	}
}

// Find finds all events as api.Events.
func (s *EventService) Find(association string) []api.Event {
	s.Logger.Log("action", "find")
	var events []api.Event
	s.DB.Find(&events)
	return events
}
