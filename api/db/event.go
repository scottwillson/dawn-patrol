package db

import (
	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api"
)

// EventService implements api.EventService
type EventService struct {
	DB *gorm.DB
}

func (s EventService) Create(events []api.Event) {
	for _, event := range events {
		s.DB.Create(event)
	}
}

// Find all events
func (s EventService) Find() []api.Event {
	var events []api.Event
	s.DB.Find(&events)
	return events
}
