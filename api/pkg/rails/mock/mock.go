package mock

import "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"

// EventService mocks db.RailsService.
type EventService struct{}

// Copy mocks rails.db.EventService.Copy().
func (s *EventService) Copy() {}

// Find mocks rails.db.EventService.Find().
func (s *EventService) Find() []rails.Event {
	return []rails.Event{}
}
