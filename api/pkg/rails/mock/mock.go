package mock

import "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"

// EventService mocks db.RailsService.
type EventService struct{}

// Find mocks rails.db.EventService.Find().
func (s *EventService) Find(association string) []rails.Event {
	return []rails.Event{}
}

// RacingAssociationService mocks db.RacingAssociationService
type RacingAssociationService struct{}

// Copy mocks rails.db.RacingAssociationService.Copy().
func (s *RacingAssociationService) Copy(association string) error {
	return nil
}

// Find mocks db.RacingAssociationService.Find().
func (s *RacingAssociationService) Find(shortName string) (*rails.RacingAssociation, error) {
	return &rails.RacingAssociation{Name: "Cascadia Bicycle Racing Association", ID: 1, ShortName: "CBRA"}, nil
}
