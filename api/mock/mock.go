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

// RacingOnRailsService mocks db.RacingOnRailsService
type RacingOnRailsService struct {
	CopyFn func() bool
}

// Copy mocks db.RacingOnRailsService.Copy()
func (s *RacingOnRailsService) Copy() bool {
	return s.CopyFn()
}
