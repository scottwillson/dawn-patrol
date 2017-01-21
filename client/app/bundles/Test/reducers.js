import { combineReducers } from 'redux';
import {
  SELECT_YEAR, INVALIDATE_YEAR,
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
  didInvalidate: false,
  events: []
}, action) {
  switch (action.type) {
  case INVALIDATE_YEAR:
    return Object.assign({}, state, {
      didInvalidate: true
    });
  case REQUEST_EVENTS:
    return Object.assign({}, state, {
      isFetching: true,
      didInvalidate: false
    });
  case RECEIVE_EVENTS:
    return Object.assign({}, state, {
      isFetching: false,
      didInvalidate: false,
      events: action.events,
      lastUpdated: action.receivedAt
    });
  default:
    return state;
  }
}

function eventsByYear(state = { }, action) {
  switch (action.type) {
  case INVALIDATE_YEAR:
  case RECEIVE_EVENTS:
  case REQUEST_EVENTS:
    return Object.assign({}, state, {
      [action.year]: events(state[action.year], action)
    });
  default:
    return state;
  }
}

const rootReducer = combineReducers({
  eventsByYear,
  selectedYear
});

export default rootReducer;
