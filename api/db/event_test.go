package db

import (
	"errors"
	"sort"
	"testing"
	"time"

	"rocketsurgeryllc.com/dawnpatrol/api"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

type ByName []api.Event

func (a ByName) Len() int           { return len(a) }
func (a ByName) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByName) Less(i, j int) bool { return a[i].Name < a[j].Name }

func TestCreate(t *testing.T) {
	db, err := openDb()
	if err != nil {
		panic(err)
	}
	defer db.Close()

	db.Delete(api.Event{})

	var service EventService
	service.DB = db

	events := []api.Event{
		api.Event{Name: "Copperopolis Road Race"},
		api.Event{Name: "Sausalito Criterium"},
	}
	service.Create(events)

	events = service.Find()

	sort.Sort(ByName(events))

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}

	if events[0].Name != "Copperopolis Road Race" {
		t.Errorf("Expect event name to be 'Copperopolis Road Race', but is %v", events[0].Name)
	}

	if events[1].Name != "Sausalito Criterium" {
		t.Errorf("Expect event name to be 'Sausalito Criterium', but is %v", events[1].Name)
	}
}

func TestFind(t *testing.T) {
	db, err := openDb()
	if err != nil {
		panic(err)
	}
	defer db.Close()

	db.Delete(&api.Event{})
	db.Create(&api.Event{})
	db.Create(&api.Event{})

	var service EventService
	service.DB = db

	var events = service.Find()

	if len(events) != 2 {
		t.Errorf("Expect events len to be 2, but is %v", len(events))
	}
}

// TODO DRY and rename to something like open PD DB
func openDb() (*gorm.DB, error) {
	for attempts := 0; attempts < 4; attempts++ {
		if db, err := gorm.Open("postgres", "postgres://dawnpatrol@db/dawnpatrol_test?sslmode=disable"); err == nil && db != nil {
			return db, err
		}
		time.Sleep(time.Duration(1 * time.Second))
	}

	return nil, errors.New("Could not connect to database")
}
