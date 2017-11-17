package db

import (
	"fmt"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/rails"

	newrelic "github.com/newrelic/go-agent"
)

type instrumentedEventService struct {
	NewRelicApp  newrelic.Application
	EventService rails.EventService
}

type instrumentedRacingAssociationService struct {
	NewRelicApp              newrelic.Application
	RacingAssociationService rails.RacingAssociationService
}

// NewInstrumentedEventService instruments a service with New Relic. It starts
// a New Relic transaction and then delegates to services functions. This
// function returns the wrapped Service.
func NewInstrumentedEventService(nr newrelic.Application, es rails.EventService) rails.EventService {
	if nr == nil {
		return es
	}

	return &instrumentedEventService{
		NewRelicApp:  nr,
		EventService: es,
	}
}

// NewInstrumentedRacingAssociationService instruments a service with New Relic. It starts
// a New Relic transaction and then delegates to services functions. This
// function returns the wrapped Service.
func NewInstrumentedRacingAssociationService(nr newrelic.Application, s rails.RacingAssociationService) rails.RacingAssociationService {
	if nr == nil {
		return s
	}

	return &instrumentedRacingAssociationService{
		NewRelicApp:              nr,
		RacingAssociationService: s,
	}
}

func (is *instrumentedRacingAssociationService) Copy(association string) error {
	s := is.RacingAssociationService

	txn := is.NewRelicApp.StartTransaction(fmt.Sprintf("%T", s), nil, nil)
	txn.SetName("rails.db.RacingAssociationService#Copy()")
	defer txn.End()

	return s.Copy(association)
}

func (ies *instrumentedEventService) Find(association string) []rails.Event {
	es := ies.EventService

	txn := ies.NewRelicApp.StartTransaction(fmt.Sprintf("%T", es), nil, nil)
	txn.SetName("rails.db.EventService#Find()")
	defer txn.End()

	return es.Find(association)
}
func (is *instrumentedRacingAssociationService) Find(association string) (*rails.RacingAssociation, error) {
	s := is.RacingAssociationService

	txn := is.NewRelicApp.StartTransaction(fmt.Sprintf("%T", s), nil, nil)
	txn.SetName("rails.db.RacingAssociationService#Find()")
	defer txn.End()

	return s.Find(association)
}
