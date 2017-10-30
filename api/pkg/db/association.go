package db

import (
	"github.com/go-kit/kit/log"

	"github.com/jinzhu/gorm"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg"
)

// AssociationService implements api.EventService.
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
func (s *AssociationService) CreateDefault() {
	s.Logger.Log("action", "create_default")
	association := api.Association{
		Acronym: "CBRA",
		Name:    "Cascadia Bicycle Racing Association",
	}
	s.Create(association)
}
