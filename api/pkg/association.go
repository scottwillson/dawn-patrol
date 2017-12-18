package api

import "time"

// Association is a bike racing association like OBRA or USA Cycling
type Association struct {
	Acronym        string    `json:"acronym"`
	CreatedAt      time.Time `json:"createdAt"`
	Host           string    `json:"host"`
	ID             int       `json:"id"`
	Name           string    `json:"name"`
	RailsCreatedAt time.Time `json:"railsCreatedAt"`
	RailsUpdatedAt time.Time `json:"railsUpdatedAt"`
	UpdatedAt      time.Time `json:"updatedAt"`
}

// AssociationService manages Associations.
type AssociationService interface {
	Create(*Association)
	CreateDefault() Association
	Default() Association
	DefaultOrCreateDefault() Association
	FirstByHost(string) (Association, error)
	FirstOrCreate(*Association)
}
