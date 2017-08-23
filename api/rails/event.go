package rails

// Event is a bike race in the Racing on Rails DB
type Event struct {
	Name string `json:"name"`
}

// EventService copies data from Racing on Rails MySQL DB
type EventService interface {
	Copy()
	Find() []Event
}
