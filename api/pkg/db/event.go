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
		// TODO return error
		if event.AssociationID == 0 {
			panic("'AssociationID' is required")
		}

		s.DB.Create(&event)
	}
}

// Find finds all events as api.Events.
func (s *EventService) Find(association *api.Association) ([]api.Event, error) {
	s.Logger.Log("action", "find", "association", association.Acronym)

	var events []api.Event
	s.DB.Where("association_id = ?", association.ID).Find(&events)
	return events, nil
}
