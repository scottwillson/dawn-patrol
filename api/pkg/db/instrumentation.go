package db

import (
	"fmt"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"

	newrelic "github.com/newrelic/go-agent"
)

type instrumentedEventService struct {
	NewRelicApp  newrelic.Application
	EventService api.EventService
}

// NewInstrumentedEventService instruments a service with New Relic. It starts
// a New Relic transaction and then delegates to services functions. This
// function returns the wrapped Service.
func NewInstrumentedEventService(nr newrelic.Application, es api.EventService) api.EventService {
	if nr == nil {
		return es
	}

	return &instrumentedEventService{
		NewRelicApp:  nr,
		EventService: es,
	}
}

func (ies *instrumentedEventService) Create(events []api.Event) {
	es := ies.EventService

	txn := ies.NewRelicApp.StartTransaction(fmt.Sprintf("%T", es), nil, nil)
	txn.SetName("db.EventService#Create()")
	defer txn.End()

	es.Create(events)
}

func (ies *instrumentedEventService) Find(association *api.Association) ([]api.Event, error) {
	es := ies.EventService

	txn := ies.NewRelicApp.StartTransaction(fmt.Sprintf("%T", es), nil, nil)
	txn.SetName("db.EventService#Find()")
	txn.AddAttribute("association", association.Acronym)
	defer txn.End()

	events, err := es.Find(association)
	return events, err
}

type instrumentedAssociationService struct {
	NewRelicApp        newrelic.Application
	AssociationService api.AssociationService
}

// NewInstrumentedAssociationService instruments a service with New Relic. It starts
// a New Relic transaction and then delegates to services functions. This
// function returns the wrapped Service.
func NewInstrumentedAssociationService(nr newrelic.Application, as api.AssociationService) api.AssociationService {
	if nr == nil {
		return as
	}

	return &instrumentedAssociationService{
		NewRelicApp:        nr,
		AssociationService: as,
	}
}

func (ias *instrumentedAssociationService) CreateAssociation(association *api.Association) {
	as := ias.AssociationService

	txn := ias.NewRelicApp.StartTransaction(fmt.Sprintf("%T", as), nil, nil)
	txn.SetName("db.AssociationService#Create()")
	defer txn.End()

	as.CreateAssociation(association)
}

func (ias *instrumentedAssociationService) CreateDefaultAssociation() api.Association {
	as := ias.AssociationService

	txn := ias.NewRelicApp.StartTransaction(fmt.Sprintf("%T", as), nil, nil)
	txn.SetName("db.AssociationService#CreateDefaultAssociation()")
	defer txn.End()

	return as.CreateDefaultAssociation()
}

func (ias *instrumentedAssociationService) Default() api.Association {
	as := ias.AssociationService

	txn := ias.NewRelicApp.StartTransaction(fmt.Sprintf("%T", as), nil, nil)
	txn.SetName("db.AssociationService#Default()")
	defer txn.End()

	return as.Default()
}

func (ias *instrumentedAssociationService) DefaultOrCreateDefaultAssociation() api.Association {
	as := ias.AssociationService

	txn := ias.NewRelicApp.StartTransaction(fmt.Sprintf("%T", as), nil, nil)
	txn.SetName("db.AssociationService#DefaultOrCreateDefaultAssociation()")
	defer txn.End()

	return as.DefaultOrCreateDefaultAssociation()
}

func (ias *instrumentedAssociationService) FirstByHost(host string) (api.Association, error) {
	as := ias.AssociationService

	txn := ias.NewRelicApp.StartTransaction(fmt.Sprintf("%T", as), nil, nil)
	txn.SetName("db.AssociationService#FirstByHost()")
	defer txn.End()

	return as.FirstByHost(host)
}

func (ias *instrumentedAssociationService) FirstOrCreate(association *api.Association) {
	as := ias.AssociationService

	txn := ias.NewRelicApp.StartTransaction(fmt.Sprintf("%T", as), nil, nil)
	txn.SetName("db.AssociationService#FirstOrCreate()")
	defer txn.End()

	as.FirstOrCreate(association)
}
