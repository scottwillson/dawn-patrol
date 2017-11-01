package db

import (
	"github.com/go-kit/kit/log"

	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
)

// AssociationService implements api.EventService.
// TODO move
type AssociationService struct {
	DB     *gorm.DB
	Logger log.Logger
}

// Create creates api.Association.
func (s *AssociationService) Create(association api.Association) {
	s.Logger.Log("action", "create")
	s.DB.Create(association)
}

// CreateDefault creates default CBRA api.Association.
func (s *AssociationService) CreateDefault() api.Association {
	s.Logger.Log("action", "create_default")
	association := api.Association{
		Acronym: "CBRA",
		Name:    "Cascadia Bicycle Racing Association",
	}
	s.Create(association)
	return association
}

// Default finds default CBRA api.Association.
func (s *AssociationService) Default() api.Association {
	s.Logger.Log("action", "first_default")
	association := api.Association{}
	s.DB.Where(&api.Association{Acronym: "CBRA"}).First(&association)
	return association
}

// DefaultOrCreateDefault returns default Association. Creates it with acronym CBRA
// if it doesn't exist.
func (s *AssociationService) DefaultOrCreateDefault() api.Association {
	s.Logger.Log("action", "first_or_create_default")
	association := api.Association{}
	s.DB.Where(api.Association{Acronym: "CBRA"}).FirstOrCreate(&association)
	return association
}
