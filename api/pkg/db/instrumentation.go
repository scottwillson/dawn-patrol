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

// NewInstrumentedHandler instruments an HTTP Handler with New Relic. It starts a New Relic transaction and then delegates to the Handler's
// ServeHTTP() function. This function returns the wrapped Handler.
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

func (ies *instrumentedEventService) Find() []api.Event {
	es := ies.EventService

	txn := ies.NewRelicApp.StartTransaction(fmt.Sprintf("%T", es), nil, nil)
	txn.SetName("db.EventService#Find()")
	defer txn.End()

	return es.Find()
}