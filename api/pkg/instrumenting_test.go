package api

import (
	stdprometheus "github.com/prometheus/client_golang/prometheus"

	"testing"

	kitprometheus "github.com/go-kit/kit/metrics/prometheus"
)

func TestInstrumentedCreate(t *testing.T) {
	fieldKeys := []string{"method"}

	var es EventService
	es = &MockEventService{}

	NewInstrumentingService(
		kitprometheus.NewCounterFrom(stdprometheus.CounterOpts{
			Namespace: "api",
			Subsystem: "event_service",
			Name:      "request_count",
			Help:      "Number of requests received.",
		}, fieldKeys),
		kitprometheus.NewSummaryFrom(stdprometheus.SummaryOpts{
			Namespace: "api",
			Subsystem: "event_service",
			Name:      "request_latency_microseconds",
			Help:      "Total duration of requests in microseconds.",
		}, fieldKeys),
		es,
	)
}
