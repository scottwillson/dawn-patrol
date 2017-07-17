import { combineReducers } from 'redux';
import {
  END_FETCHING,
  RECEIVE_EVENTS,
  REQUEST_EVENTS,
  SELECT_YEAR,
  START_FETCHING
} from './actions';

function year(state = null, action) {
  switch (action.type) {
  case SELECT_YEAR:
    return action.year;
  default:
    return state;
  }
}

function fetching(state = false, action) {
  switch (action.type) {
  case START_FETCHING:
    return true;
  case END_FETCHING:
    return false;
  default:
    return state;
  }
}

function events(state = [], action) {
  switch (action.type) {
  case RECEIVE_EVENTS:
    return Object.assign({}, state, {
      events: action.events,
      linkGroups: action.linkGroups
    });
  default:
    return state;
  }
}
const rootReducer = combineReducers({
  fetching,
  events,
  year
});

export default rootReducer;
