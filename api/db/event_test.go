package db

import (
	"errors"
	"testing"
	"time"

	"rocketsurgeryllc.com/dawnpatrol/api"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestFind(t *testing.T) {
	db, err := openDb()
	if err != nil {
		panic(err)
	}
	defer db.Close()

	db.Delete(api.Event{})
	db.Create(&api.Event{})
	db.Create(&api.Event{})

	var service EventService
	service.DB = db

	var events = service.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}

func openDb() (*gorm.DB, error) {
	for attempts := 0; attempts < 4; attempts++ {
		if db, err := gorm.Open("postgres", "postgres://dawnpatrol@db/dawnpatrol_test?sslmode=disable"); err == nil && db != nil {
			return db, err
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	return nil, errors.New("Could not connect to database")
}
