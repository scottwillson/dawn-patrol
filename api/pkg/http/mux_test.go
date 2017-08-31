package http

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestNewMux(t *testing.T) {
	mux := NewMux(MuxConfig{})
	assert.NotNil(t, mux, "Mux")
}
