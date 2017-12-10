package db

import (
	"testing"

	gokitLog "github.com/go-kit/kit/log"
	"github.com/jinzhu/gorm"
	"github.com/stretchr/testify/assert"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

// SetupTest deletes all data, creates default Association and
// returns reference to DB and mock Logger
func SetupTest(t *testing.T) (api.Association, *gorm.DB, gokitLog.Logger, *assert.Assertions) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()

	db.Delete(&api.Event{})
	db.Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	association := as.CreateDefault()
	assert := assert.New(t)

	return association, db, &logger, assert
}
