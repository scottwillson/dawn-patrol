package rails

import "time"

// Event is a bike race in the Racing on Rails DB.
// TODO Need json annotation here?
type Event struct {
	City       string    `json:"city"`
	CreatedAt  time.Time `json:"createdAt"`
	Date       time.Time `json:"date"`
	Discipline string    `json:"discipline"`
	ID         int       `json:"id"`
	Name       string    `json:"name"`
	State      string    `json:"state"`
	UpdatedAt  time.Time `json:"updatedAt"`
}

// EventService copies data from Racing on Rails MySQL DB.
type EventService interface {
	Copy(string) error
	Find(string) []Event
}
