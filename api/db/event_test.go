package db

import (
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func TestFind(t *testing.T) {
	db, err := gorm.Open("postgres", "postgres://dawnpatrol@db/dawnpatrol?sslmode=disable")
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
