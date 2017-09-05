package api

// MockEventService mocks db.EventService.
type MockEventService struct {
	FindFn func() []Event
}

// Create mocks db.EventService.Create().
func (s *MockEventService) Create([]Event) {}

// Find mocks db.EventService.Find().
func (s *MockEventService) Find() []Event {
	if s.FindFn != nil {
		return s.FindFn()
	}

	return []Event{}
}

type MockLogger struct{}

func (l *MockLogger) Log(keyvals ...interface{}) error {
	return nil
}
