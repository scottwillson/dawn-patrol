package db

import (
	gokitLog "github.com/go-kit/kit/log"
	"github.com/jinzhu/gorm"
	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

// Setup deletes all data, creates default Association and
// returns reference to DB and mock Logger
func SetupTest() (api.Association, *gorm.DB, gokitLog.Logger) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()

	db.Unscoped().Delete(&api.Event{})
	db.Unscoped().Delete(&api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	association := as.CreateDefault()

	return association, db, &logger
}
