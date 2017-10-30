package db

import (
	"testing"

	api "rocketsurgeryllc.com/dawnpatrol/api/pkg"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/log"
)

func TestCreateDefault(t *testing.T) {
	logger := log.MockLogger{}
	dbs := Databases{Logger: &logger}
	db := dbs.Default()
	defer db.Close()

	db.Delete(api.Association{})

	as := AssociationService{DB: db, Logger: &logger}
	as.CreateDefault()

	// TODO find association
}

// TODO test create if default already exists
// TODO instrument
// TODO test find
