package mock

import "rocketsurgeryllc.com/dawnpatrol/api/pkg"

// EventService mocks db.EventService.
type EventService struct {
	FindFn func() []api.Event
}

// Create mocks db.EventService.Create().
func (s *EventService) Create([]api.Event) {}

// Find mocks db.EventService.Find().
func (s *EventService) Find() []api.Event {
	return s.FindFn()
}

type Logger struct{}

func (l *Logger) Log(keyvals ...interface{}) error {
	return nil
}
