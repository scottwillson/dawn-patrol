package mock

import "rocketsurgeryllc.com/dawnpatrol/api/rails"

// RailsService mocks db.RailsService
type EventService struct {
	CopyFn func() bool
}

// Copy mocks rails.db.EventService.Copy()
func (s *EventService) Copy() bool {
	return s.CopyFn()
}

// Find mocks rails.db.EventService.Find()
func (s *EventService) Find() []rails.Event {
	return []rails.Event{}
}
