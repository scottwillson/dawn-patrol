package db

// RailsService implements api.RailsService
type RailsService struct {
}

// Copy from Racing on Rails MySQL DB
func (s RailsService) Copy() bool {
	return true
}
