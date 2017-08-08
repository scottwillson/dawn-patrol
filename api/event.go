package api

// Event is a bike race
type Event struct {
	Name string `json:"name"`
}

// EventService manages Events
type EventService interface {
	Find() []Event
}
