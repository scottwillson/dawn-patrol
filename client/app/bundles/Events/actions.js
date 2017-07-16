import fetch from 'isomorphic-fetch';

export const REQUEST_EVENTS = 'REQUEST_EVENTS';
export const RECEIVE_EVENTS = 'RECEIVE_EVENTS';
export const SELECT_YEAR = 'SELECT_YEAR';

export function selectYear(year) {
  return {
    type: SELECT_YEAR,
    year
  };
}

function requestEvents(year) {
  return {
    type: REQUEST_EVENTS,
    year
  };
}

function receiveEvents(json) {
  return {
    type: RECEIVE_EVENTS,
    year: json.year,
    events: json.events,
    linkGroups: json.link_groups
  };
}

function fetchEvents(year) {
  return dispatch => {
    dispatch(requestEvents(year));
    return fetch(`/events.json?year=${year}`)
      .then(req => req.json())
      .then(json => dispatch(receiveEvents(json)));
  }
}

function shouldFetchEvents(state, year) {
  return !state.events.isFetching
}

export function fetchEventsIfNeeded(year) {
  return (dispatch, getState) => {
    if (shouldFetchEvents(getState(), year)) {
      return dispatch(fetchEvents(year));
    }
  };
}
