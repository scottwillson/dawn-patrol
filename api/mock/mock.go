package mock

import "rocketsurgeryllc.com/dawnpatrol/api"

// EventService mocks db.EventService
type EventService struct {
	FindFn func() []api.Event
}

// Find mocks db.EventService.Find()
func (s *EventService) Find() []api.Event {
	return s.FindFn()
}

// RailsService mocks db.RailsService
type RailsService struct {
	CopyFn func() bool
}

// Copy mocks db.RailsService.Copy()
func (s *RailsService) Copy() bool {
	return s.CopyFn()
}
