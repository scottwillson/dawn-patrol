package db

import (
	"testing"

	"github.com/stretchr/testify/assert"
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
	association := as.CreateDefault()

	assert.Equal(t, "CBRA", association.Acronym, "Association acronym")
	// TODO find association
}

// TODO test create if default already exists
// TODO instrument
// TODO test find
