package db

import (
	"os"
	"time"

	"github.com/go-kit/kit/log"
	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// EventService implements api.rails.EventService.
type EventService struct {
	APIEventService api.EventService
	DB              db.Databases
	Logger          log.Logger
}

// Copy copies events for an association from the Racing on Rails MySQL DB to Dawn Patrol DB.
func (s *EventService) Copy(association string) error {
	s.Logger.Log("action", "copy", "association", association)

	var railsEvents []rails.Event
	s.DB.For(association).Find(&railsEvents)
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
func (s *EventService) Find() []rails.Event {
	s.Logger.Log("action", "find")

	var events []rails.Event
	s.DB.Find(&events)
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

func Open(logger log.Logger) *gorm.DB {
	url := railsDatabaseURL()
	logger.Log("action", "open", "url", url)
	return db.OpenURL(url)
}

func railsDatabaseURL() string {
	databaseURL := os.Getenv("RAILS_DATABASE_URL")
	if databaseURL == "" {
		return "rails:rails@tcp(rails-db:3306)/rails?parseTime=True"
	}
	return databaseURL
}
