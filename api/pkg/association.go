package api

// Association is a bike racing association like OBRA or USA Cycling
type Association struct {
	Acronym string `json:"acronym"`
	Host    string `json:"host"`
	ID      int    `json:"id"`
	Name    string `json:"name"`
}

// AssociationService manages Associations.
type AssociationService interface {
	CreateAssociation(Association)
	CreateDefault() Association
	Default() Association
	DefaultOrCreateDefault() Association
	FirstAcronymByHost(string) string
	FirstOrCreate(Association) Association
}
