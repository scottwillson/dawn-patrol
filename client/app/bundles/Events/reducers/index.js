import { combineReducers } from 'redux';
import { events, error, eventsIsLoading, year } from './events';

export default combineReducers({
  events,
  error,
  eventsIsLoading,
  year
});
