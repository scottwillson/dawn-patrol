package db

import (
	"github.com/go-kit/kit/log"

	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
)

// AssociationService implements api.AssociationService.
type AssociationService struct {
	DB     *gorm.DB
	Logger log.Logger
}

// CreateAssociation creates api.Association.
func (s *AssociationService) CreateAssociation(association *api.Association) {
	s.Logger.Log("action", "create")
	s.DB.Create(&association)
}

// CreateDefaultAssociation creates default CBRA api.Association.
func (s *AssociationService) CreateDefaultAssociation() api.Association {
	s.Logger.Log("action", "create_default")
	// association := newDefault()
	association := api.Association{
		Acronym: "CBRA",
		Host:    "0.0.0.0|localhost|cbra.local",
		Name:    "Cascadia Bicycle Racing Association",
	}
	s.CreateAssociation(&association)
	return association
}

// Default finds default CBRA api.Association.
func (s *AssociationService) Default() api.Association {
	s.Logger.Log("action", "default")
	association := api.Association{}
	s.DB.Where(&api.Association{Acronym: "CBRA"}).First(&association)
	return association
}

// DefaultOrCreateDefaultAssociation returns default Association. Creates it with acronym CBRA
// if it doesn't exist.
func (s *AssociationService) DefaultOrCreateDefaultAssociation() api.Association {
	s.Logger.Log("action", "default_or_create_default")
	association := api.Association{}
	s.DB.Where(newDefault()).FirstOrCreate(&association)
	return association
}

// FirstAcronymByHost finds first Association acronym that matches host.
// Does a regex match and honors position.
// TODO just return Association?
func (s *AssociationService) FirstAcronymByHost(host string) string {
	association := api.Association{}
	s.DB.Where("host  ~* ?", host).First(&association)
	return association.Acronym
}

// FirstOrCreate finds first Association that matches acronym or creates Association
func (s *AssociationService) FirstOrCreate(association *api.Association) {
	s.Logger.Log("action", "first_or_create")
	s.DB.FirstOrCreate(&association)
}

func newDefault() api.Association {
	return api.Association{
		Acronym: "CBRA",
		Host:    "0.0.0.0|localhost|cbra.local",
		Name:    "Cascadia Bicycle Racing Association",
	}
}
