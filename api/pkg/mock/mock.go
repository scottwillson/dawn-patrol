package mock

import "rocketsurgeryllc.com/dawnpatrol/api/pkg"

// EventService mocks db.EventService.
type EventService struct {
	FindFn func() []api.Event
}

// Create mocks db.EventService.Create().
func (s *EventService) Create([]api.Event) error {
	return nil
}

// Find mocks db.EventService.Find().
func (s *EventService) Find(_ *api.Association) ([]api.Event, error) {
	if s.FindFn != nil {
		return s.FindFn(), nil
	}

	return []api.Event{}, nil
}

// AssociationService mocks db.AssociationService
type AssociationService struct {
}

// Create creates api.Association.
func (s *AssociationService) Create(association *api.Association) {
}

// CreateDefault creates default CBRA api.Association.
func (s *AssociationService) CreateDefault() api.Association {
	return newMock()
}

// Default finds default CBRA api.Association.
func (s *AssociationService) Default() api.Association {
	return newMock()
}

// DefaultOrCreateDefault returns default Association. Creates it with acronym CBRA
// if it doesn't exist.
func (s *AssociationService) DefaultOrCreateDefault() api.Association {
	return newMock()
}

// FirstByHost mocks db implementation
func (s *AssociationService) FirstByHost(host string) (api.Association, error) {
	return newMock(), nil
}

// FirstOrCreate mocks db implementation
func (s *AssociationService) FirstOrCreate(association *api.Association) {
}

func newMock() api.Association {
	return api.Association{
		Acronym: "MOCK",
		Host:    "mock.web",
		Name:    "Mock Bicycle Racing Association",
	}
}
