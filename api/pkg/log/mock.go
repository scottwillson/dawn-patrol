package log

// MockLogger mocks go-kit/log.Logger
type MockLogger struct{}

// Log mocks go-kit/log.Logger.Log
func (l *MockLogger) Log(keyvals ...interface{}) error {
	return nil
}
