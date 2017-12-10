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

// Create creates api.Association.
func (s *AssociationService) Create(association *api.Association) {
	s.Logger.Log("action", "create", "association", association.Acronym)
	s.DB.Create(&association)
}

// CreateDefault creates default CBRA api.Association.
func (s *AssociationService) CreateDefault() api.Association {
	s.Logger.Log("action", "create_default")
	association := newDefault()
	s.Create(&association)
	return association
}

// Default finds default CBRA api.Association.
func (s *AssociationService) Default() api.Association {
	s.Logger.Log("action", "default")
	association := api.Association{}
	s.DB.Where(&api.Association{Acronym: "CBRA"}).First(&association)
	return association
}

// DefaultOrCreateDefault returns default Association. Creates it with acronym CBRA
// if it doesn't exist.
func (s *AssociationService) DefaultOrCreateDefault() api.Association {
	s.Logger.Log("action", "default_or_create_default")
	association := newDefault()
	s.DB.Where(newDefault()).FirstOrCreate(&association)
	return association
}

// FirstByHost finds first Association that matches host.
// Does a regex match and honors position.
func (s *AssociationService) FirstByHost(host string) (api.Association, error) {
	s.Logger.Log("action", "find_by_host", "host", host)
	association := api.Association{}
	err := s.DB.Where("? ~* host", host).First(&association).Error
	return association, err
}

// FirstOrCreate finds first Association that matches acronym or creates Association
func (s *AssociationService) FirstOrCreate(association *api.Association) {
	s.Logger.Log("action", "first_or_create", "association", association.Acronym)
	s.DB.Where(api.Association{Acronym: association.Acronym}).First(&association)
	if s.DB.NewRecord(association) {
		s.Create(association)
	}
}

func newDefault() api.Association {
	return api.Association{
		Acronym: "CBRA",
		Host:    "0.0.0.0|localhost|cbra.web",
		Name:    "Cascadia Bicycle Racing Association",
	}
}
