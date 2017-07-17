import { combineReducers } from 'redux';
import { events, error, eventsIsLoading } from './events';

export default combineReducers({
  events,
  error,
  eventsIsLoading
});
