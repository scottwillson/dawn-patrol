package api

// Event is a bike race on a date or dates with (optional) categories and results.
type Event struct {
	Name string `json:"name"`
}

// EventService manages Events.
type EventService interface {
	Create([]Event)
	Find() []Event
}
