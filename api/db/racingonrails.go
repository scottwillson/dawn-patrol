package db

// RacingOnRailsService implements api.RacingOnRailsService
type RacingOnRailsService struct {
}

// Copy from Racing on Rails MySQL DB
func (s RacingOnRailsService) Copy() bool {
	return true
}
