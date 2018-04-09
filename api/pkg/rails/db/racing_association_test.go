package db

import (
	"testing"
	"time"

	"rocketsurgeryllc.com/dawnpatrol/api/pkg/db"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/stretchr/testify/assert"
)

func TestToAssociationTimeZone(t *testing.T) {
	utcDate := time.Date(2009, 7, 3, 0, 0, 0, 0, time.UTC)

	assocDate, err := ToAssociationTimeZone(utcDate)
	if err != nil {
		t.Error(err)
	}

	pacific, err := time.LoadLocation("America/Los_Angeles")
	if err != nil {
		t.Error(err)
	}

	dateInPacific := time.Date(2009, 7, 3, 0, 0, 0, 0, pacific)
	if !dateInPacific.Equal(assocDate) {
		t.Errorf("ToAssociationTimeZone should convert time %v to association time zone %v", assocDate, dateInPacific)
	}
}

func TestFind(t *testing.T) {
	logger := log.MockLogger{}
	dbs := db.Databases{Logger: &logger}

	service := &RacingAssociationService{Databases: dbs, Logger: &logger}

	association, err := service.Find("CBRA")
	if err != nil {
		t.Error(err)
	}

	assert.Equal(t, "Cascadia Bicycle Racing Association", association.Name, "association name")
	assert.Equal(t, "CBRA", association.ShortName, "association short name")
}
