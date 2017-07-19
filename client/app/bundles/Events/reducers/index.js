import { combineReducers } from 'redux';
import { events, error, eventsIsLoading, year, years } from './events';

export default combineReducers({
  error,
  eventsIsLoading,
  year,
  years,
  events
});
