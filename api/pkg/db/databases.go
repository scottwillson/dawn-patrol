package db

import (
	"github.com/go-kit/kit/log"
	"github.com/jinzhu/gorm"
)

// Databases is a factory for DB connections
type Databases struct {
	Logger log.Logger
}

func (d Databases) Default() *gorm.DB {
	url := databaseURL()
	if d.Logger != nil {
		d.Logger.Log("action", "open", "url", url)
	}
	return OpenURL(url)
}
