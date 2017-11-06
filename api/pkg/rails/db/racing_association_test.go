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

func TestFind(t *testing.T) {
	logger := log.MockLogger{}
	dbs := db.Databases{Logger: &logger}

	service := &RacingAssociationService{Databases: dbs, Logger: &logger}

	var association = service.Find("rails")

	assert.Equal(t, "rails", association.Name, "association name")
	assert.Equal(t, "rails", association.ShortName, "association short name")
}
