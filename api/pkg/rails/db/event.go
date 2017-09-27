package db

import (
	"time"

	"github.com/go-kit/kit/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// EventService implements api.rails.EventService.
type EventService struct {
	APIEventService api.EventService
	Databases       db.Databases
	Logger          log.Logger
}

// Copy copies events for an association from the Racing on Rails MySQL DB to Dawn Patrol DB.
func (s *EventService) Copy(association string) error {
	s.Logger.Log("action", "copy", "association", association)

	var railsEvents []rails.Event
	db := s.Databases.For(association)
	defer db.Close()
	db.Find(&railsEvents)
	s.Logger.Log("action", "copy", "rails_events", len(railsEvents))

	events := make([]api.Event, len(railsEvents))
	var date time.Time
	var err error
	for i, e := range railsEvents {
		if date, err = ToAssociationTimeZone(e.Date); err != nil {
			return err
		}
		events[i] = api.Event{
			City:           e.City,
			Discipline:     e.Discipline,
			Name:           e.Name,
			RailsID:        e.ID,
			RailsCreatedAt: e.CreatedAt,
			RailsUpdatedAt: e.UpdatedAt,
			StartsAt:       date,
			State:          e.State,
		}
	}

	s.APIEventService.Create(events)

	return nil
}

// Find finds all events in the Racing on Rails MySQL DB.
func (s *EventService) Find(association string) []rails.Event {
	s.Logger.Log("action", "find")

	var events []rails.Event
	db := s.Databases.For(association)
	defer db.Close()
	db.Find(&events)
	return events
}

func ToAssociationTimeZone(date time.Time) (time.Time, error) {
	pacific, err := time.LoadLocation("America/Los_Angeles")
	if err != nil {
		return date, err
	}
	return time.Date(
		date.Year(), date.Month(), date.Day(), date.Minute(), date.Hour(), date.Second(), date.Nanosecond(), pacific), nil
}
