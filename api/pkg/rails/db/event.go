package db

import (
	"strings"
	"time"

	"github.com/go-kit/kit/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// EventService implements api.rails.EventService.
type EventService struct {
	APIEventService          api.EventService
	AssociationService       api.AssociationService
	Databases                db.Databases
	Logger                   log.Logger
	RacingAssociationService rails.RacingAssociationService
}

// Copy copies events for an association from the Racing on Rails MySQL DB to Dawn Patrol DB.
func (s *EventService) Copy(associationAcronym string) error {
	s.Logger.Log("action", "copy", "association", associationAcronym)

	var railsEvents []rails.Event
	db := s.Databases.For(associationAcronym)
	defer db.Close()
	db.Find(&railsEvents)
	s.Logger.Log("action", "copy", "rails_events", len(railsEvents))

	racingAssociation, err := s.RacingAssociationService.Find(associationAcronym)
	if err != nil {
		return err
	}

	association := api.Association{
		Acronym:        associationAcronym,
		Host:           "0.0.0.0|localhost|" + strings.ToLower(racingAssociation.ShortName) + ".web",
		Name:           racingAssociation.ShortName,
		RailsCreatedAt: racingAssociation.CreatedAt,
		RailsUpdatedAt: racingAssociation.UpdatedAt,
	}
	s.AssociationService.FirstOrCreate(&association)

	events := make([]api.Event, len(railsEvents))
	for i, e := range railsEvents {
		date, err := ToAssociationTimeZone(e.Date)
		if err != nil {
			return err
		}
		events[i] = api.Event{
			AssociationID:  association.ID,
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

// ToAssociationTimeZone converts date to Dawn Patrol Association's time zone.
// It disregards date's time zone. In other words, if date is Dec 1, 9 AM UTC
// and the Association is in Central time, ToAssociationTimeZone converts date
// to Dec 1, 9 AM CST.
func ToAssociationTimeZone(date time.Time) (time.Time, error) {
	pacific, err := time.LoadLocation("America/Los_Angeles")
	if err != nil {
		return date, err
	}
	return time.Date(
		date.Year(), date.Month(), date.Day(), date.Minute(), date.Hour(), date.Second(), date.Nanosecond(), pacific), nil
}
