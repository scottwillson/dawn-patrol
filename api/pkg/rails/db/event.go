package db

import (
	"time"

	"github.com/go-kit/kit/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// EventService implements api.rails.EventService.
type EventService struct {
	Databases                db.Databases
	Logger                   log.Logger
	RacingAssociationService rails.RacingAssociationService
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
