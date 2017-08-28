package http

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"rocketsurgeryllc.com/dawnpatrol/api/pkg/mock"
	railsMock "rocketsurgeryllc.com/dawnpatrol/api/pkg/rails/mock"
)

func TestNewMux(t *testing.T) {
	mux := NewMux(&mock.EventService{}, &railsMock.EventService{})
	assert.NotNil(t, mux, "Mux")
}
