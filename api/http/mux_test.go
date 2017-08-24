package http

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/mock"
	railsMock "rocketsurgeryllc.com/dawnpatrol/api/rails/mock"
)

func TestNewMux(t *testing.T) {
	mux := NewMux(&mock.EventService{}, &railsMock.EventService{})
	assert.NotNil(t, mux, "Mux")
}
