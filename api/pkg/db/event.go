package db

import (
	"errors"
	"fmt"

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
		s.DB.Create(&event)
	}
}

// Find finds all events as api.Events.
func (s *EventService) Find(association string) ([]api.Event, error) {
	s.Logger.Log("action", "find", "association", association)

	if association == "" {
		return nil, errors.New("'association' cannot be blank")
	}

	type Count struct {
		Count int
	}

	var count Count
	s.DB.Raw("SELECT count(*) as count FROM associations WHERE acronym = ?", association).Scan(&count)

	if count.Count < 1 {
		return nil, fmt.Errorf("'%s' does not exist", association)
	}

	var events []api.Event
	s.DB.Find(&events)
	return events, nil
}
