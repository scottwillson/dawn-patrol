package api

import "time"

// Event is a bike race on a date or dates with (optional) categories and results.
type Event struct {
	StartsAt time.Time `json:"startsAt"`
	Name     string    `json:"name"`
}

// EventService manages Events.
type EventService interface {
	Create([]Event)
	Find() []Event
}

// ByName is a predicate to sort Events by Name
type ByName []Event

func (a ByName) Len() int           { return len(a) }
func (a ByName) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByName) Less(i, j int) bool { return a[i].Name < a[j].Name }
