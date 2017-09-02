package api

import (
	"os"

	"github.com/go-kit/kit/log"
	newrelic "github.com/newrelic/go-agent"
)

// NewNewRelicApp creates a new New Relic Application with license set from NEW_RELIC_LICENSE_KEY.
// The New Relic app name is set from DAWN_PATROL_ENVIRONMENT, and defaults to just 'Dawn Patrol' (production).
func NewNewRelicApp(logger log.Logger) newrelic.Application {
	license := os.Getenv("NEW_RELIC_LICENSE_KEY")
	logger.Log("component", "instrumentation", "new_relic_license_key", license != "")
	if license == "" {
		return nil
	}

	config := newrelic.NewConfig(appName(), license)
	app, err := newrelic.NewApplication(config)
	if err != nil {
		panic(err)
	}

	return app
}

func appName() string {
	dpEnv := os.Getenv("DAWN_PATROL_ENVIRONMENT")
	if dpEnv == "" {
		return "Dawn Patrol"
	}
	return "Dawn Patrol " + dpEnv
}
