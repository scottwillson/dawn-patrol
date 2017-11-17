package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestRailsFind(t *testing.T) {
	logger := log.MockLogger{}
	dbs := db.Databases{Logger: &logger}

	eventService := &EventService{Databases: dbs, Logger: &logger}

	var events = eventService.Find("CBRA")

	assert.Equal(t, 2, len(events), "events")
}
