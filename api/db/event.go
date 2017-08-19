package db

import (
	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api"
)

// EventService implements api.EventService
type EventService struct {
	DB *gorm.DB
}

// Find all events
func (s EventService) Find() []api.Event {
	var events []api.Event
	s.DB.Find(&events)
	return events
}
