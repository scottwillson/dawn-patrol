package rails

import "time"

// RacingAssociation is a racing association in the Racing on Rails DB.
type RacingAssociation struct {
	CreatedAt time.Time
	ID        int
	Name      string
	ShortName string
	UpdatedAt time.Time
}

// RacingAssociationService copies data from Racing on Rails MySQL DB.
type RacingAssociationService interface {
	Find(string) (*RacingAssociation, error)
}
