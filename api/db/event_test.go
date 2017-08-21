package db

import (
	"sort"
	"testing"

	"rocketsurgeryllc.com/dawnpatrol/api"
)

type ByName []api.Event

func (a ByName) Len() int           { return len(a) }
func (a ByName) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByName) Less(i, j int) bool { return a[i].Name < a[j].Name }

func TestCreate(t *testing.T) {
	db := Open()
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
	db := Open()
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
