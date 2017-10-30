package api

import (
	"time"
)

// Event is a bike race on a date or dates with (optional) categories and results.
type Event struct {
	Association    Association
	City           string    `json:"city"`
	Discipline     string    `json:"discipline"`
	Name           string    `json:"name"`
	RailsCreatedAt time.Time `json:"railsCreatedAt"`
	RailsID        int       `json:"railsId"`
	RailsUpdatedAt time.Time `json:"railsUpdatedAt"`
	StartsAt       time.Time `json:"startsAt"`
	State          string    `json:"state"`
}

// EventService manages Events.
type EventService interface {
	Create([]Event)
	Find(string) ([]Event, error)
}

// ByName is a predicate to sort Events by Name
type ByName []Event

func (a ByName) Len() int           { return len(a) }
func (a ByName) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByName) Less(i, j int) bool { return a[i].Name < a[j].Name }
