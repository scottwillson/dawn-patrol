package api

import (
	"time"

	"github.com/go-kit/kit/metrics"
)

type instrumentingService struct {
	requestCount   metrics.Counter
	requestLatency metrics.Histogram
	EventService
}

// NewInstrumentingService returns an instance of an instrumenting Service.
func NewInstrumentingService(counter metrics.Counter, latency metrics.Histogram, s EventService) EventService {
	return &instrumentingService{
		requestCount:   counter,
		requestLatency: latency,
		EventService:   s,
	}
}

func (s *instrumentingService) Create(events []Event) {
	defer func(begin time.Time) {
		s.requestCount.With("method", "create").Add(1)
		s.requestLatency.With("method", "create").Observe(time.Since(begin).Seconds())
	}(time.Now())
	s.EventService.Create(events)
}

func (s *instrumentingService) Find() []Event {
	defer func(begin time.Time) {
		s.requestCount.With("method", "find").Add(1)
		s.requestLatency.With("method", "find").Observe(time.Since(begin).Seconds())
	}(time.Now())

	return s.EventService.Find()
}
