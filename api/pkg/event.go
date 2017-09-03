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

type ByName []Event

func (a ByName) Len() int           { return len(a) }
func (a ByName) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByName) Less(i, j int) bool { return a[i].Name < a[j].Name }
