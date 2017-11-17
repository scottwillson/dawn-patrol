package db

import (
	"strings"

	"github.com/go-kit/kit/log"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// RacingAssociationService implements api.rails.EventService.
type RacingAssociationService struct {
	Databases          db.Databases
	APIEventService    api.EventService
	AssociationService api.AssociationService
	Logger             log.Logger
}

// Copy copies events for an association from the Racing on Rails MySQL DB to Dawn Patrol DB.
func (s *RacingAssociationService) Copy(associationAcronym string) error {
	s.Logger.Log("action", "copy", "association", associationAcronym)

	var railsEvents []rails.Event
	db := s.Databases.For(associationAcronym)
	defer db.Close()
	db.Find(&railsEvents)
	s.Logger.Log("action", "copy", "rails_events", len(railsEvents))

	racingAssociation, err := s.Find(associationAcronym)
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

// Find finds RacingAssociation by shortName (acronym)
func (s *RacingAssociationService) Find(shortName string) (*rails.RacingAssociation, error) {
	association := rails.RacingAssociation{}
	db := s.Databases.For(shortName)
	err := db.Where("short_name = ?", shortName).First(&association).Error
	return &association, err
}
