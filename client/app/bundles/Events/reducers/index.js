import { combineReducers } from 'redux';
import { events, error, eventsIsLoading, year } from './events';

export default combineReducers({
  error,
  eventsIsLoading,
  year,
  events
});
