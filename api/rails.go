package api

// RailsService copies data from Racing on Rails MySQL DB
type RailsService interface {
	Copy() bool
}
