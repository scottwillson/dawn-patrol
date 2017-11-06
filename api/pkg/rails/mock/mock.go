package mock

import "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"

// EventService mocks db.RailsService.
type EventService struct{}

// Copy mocks rails.db.EventService.Copy().
func (s *EventService) Copy(association string) error {
	return nil
}

// Find mocks rails.db.EventService.Find().
func (s *EventService) Find(association string) []rails.Event {
	return []rails.Event{}
}

// RacingAssociationService mocks db.RacingAssociationService
type RacingAssociationService struct{}

// Find mocks db.RacingAssociationService.Find().
func (s *RacingAssociationService) Find(shortName string) *rails.RacingAssociation {
	return &rails.RacingAssociation{}
}
