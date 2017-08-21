package api

// RailsEvent is a bike race in the Racing on Rails DB
type RailsEvent struct {
	Name string `json:"name"`
}

// TableName sets table name
func (RailsEvent) TableName() string {
	return "events"
}

// RailsService copies data from Racing on Rails MySQL DB
type RailsService interface {
	Copy() bool
	Find() []RailsEvent
}
