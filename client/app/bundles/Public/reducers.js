import { combineReducers } from 'redux';
import {
  SELECT_YEAR,
  REQUEST_EVENTS, RECEIVE_EVENTS
} from './actions';

function selectedYear(state = '2017', action) {
  switch (action.type) {
  case SELECT_YEAR:
    return action.year;
  default:
    return state;
  }
}

function events(state = {
  isFetching: false,
  events: []
}, action) {
  switch (action.type) {
  case REQUEST_EVENTS:
    return Object.assign({}, state, {
      isFetching: true
    });
  case RECEIVE_EVENTS:
    return Object.assign({}, state, {
      isFetching: false,
      events: action.events,
      lastUpdated: action.receivedAt
    });
  default:
    return state;
  }
}
const rootReducer = combineReducers({
  events,
  selectedYear
});

export default rootReducer;
