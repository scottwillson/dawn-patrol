package api

// Association is a bike racing association like OBRA or USA Cycling
type Association struct {
	Acronym string `json:"acronym"`
	Host    string `json:"host"`
	Name    string `json:"name"`
}

// AssociationService manages Associations.
type AssociationService interface {
	Create(Association)
	CreateDefault() Association
	Default() Association
	DefaultOrCreateDefault() Association
	FirstAcronymByHost(string) string
}
