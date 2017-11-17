package rails

import "time"

// Event is a bike race in the Racing on Rails DB.
type Event struct {
	City       string
	CreatedAt  time.Time
	Date       time.Time
	Discipline string
	ID         int
	Name       string
	State      string
	UpdatedAt  time.Time
}

// EventService copies data from Racing on Rails MySQL DB.
type EventService interface {
	Find(string) []Event
}
