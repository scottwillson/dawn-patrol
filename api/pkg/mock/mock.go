package mock

import "rocketsurgeryllc.com/dawnpatrol/api/pkg"

// EventService mocks db.EventService.
type EventService struct {
	FindFn func() []api.Event
}

// Create mocks db.EventService.Create().
func (s *EventService) Create([]api.Event) {}

// Find mocks db.EventService.Find().
func (s *EventService) Find(_ string) ([]api.Event, error) {
	if s.FindFn != nil {
		return s.FindFn(), nil
	}

	return []api.Event{}, nil
}

// AssociationService mocks db.AssociationService
type AssociationService struct {
}

// CreateAssociation creates api.Association.
func (s *AssociationService) CreateAssociation(association api.Association) {
}

// CreateDefault creates default CBRA api.Association.
func (s *AssociationService) CreateDefault() api.Association {
	return api.Association{}
}

// Default finds default CBRA api.Association.
func (s *AssociationService) Default() api.Association {
	return api.Association{}
}

// DefaultOrCreateDefault returns default Association. Creates it with acronym CBRA
// if it doesn't exist.
func (s *AssociationService) DefaultOrCreateDefault() api.Association {
	return api.Association{}
}

// FirstAcronymByHost mocks db implementation
func (s *AssociationService) FirstAcronymByHost(host string) string {
	return ""
}

// FirstOrCreate mocks db implementation
func (s *AssociationService) FirstOrCreate(association api.Association) api.Association {
	return association
}
