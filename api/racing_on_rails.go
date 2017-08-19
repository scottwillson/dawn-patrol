package api

// RacingOnRailsService copies data from Racing on Rails MySQL DB
type RacingOnRailsService interface {
	Copy() bool
}
