package db

import (
	"github.com/go-kit/kit/log"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"
)

// RacingAssociationService implements api.rails.EventService.
type RacingAssociationService struct {
	Databases db.Databases
	Logger    log.Logger
}

// Find finds RacingAssociation by shortName (acronym)
func (s *RacingAssociationService) Find(shortName string) (*rails.RacingAssociation, error) {
	association := rails.RacingAssociation{}
	db := s.Databases.For(shortName)
	err := db.Where("short_name = ?", shortName).First(&association).Error
	return &association, err
}
