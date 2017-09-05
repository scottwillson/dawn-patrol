package rails

import "time"

// Event is a bike race in the Racing on Rails DB.
type Event struct {
	Date       time.Time `json:"date"`
	Discipline string    `json:"discipline"`
	Name       string    `json:"name"`
}

// EventService copies data from Racing on Rails MySQL DB.
type EventService interface {
	Copy() error
	Find() []Event
}
