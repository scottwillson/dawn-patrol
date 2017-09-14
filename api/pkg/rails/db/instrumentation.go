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

func (ies *instrumentedEventService) Copy() error {
	es := ies.EventService

	txn := ies.NewRelicApp.StartTransaction(fmt.Sprintf("%T", es), nil, nil)
	txn.SetName("rails.db.EventService#Copy()")
	defer txn.End()

	return es.Copy()
}

func (ies *instrumentedEventService) Find() []rails.Event {
	es := ies.EventService

	txn := ies.NewRelicApp.StartTransaction(fmt.Sprintf("%T", es), nil, nil)
	txn.SetName("rails.db.EventService#Find()")
	defer txn.End()

	return es.Find()
}
