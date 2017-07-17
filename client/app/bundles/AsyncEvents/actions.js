import fetch from 'isomorphic-fetch';

export const END_FETCHING = 'END_FETCHING';
export const REQUEST_EVENTS = 'REQUEST_EVENTS';
export const RECEIVE_EVENTS = 'RECEIVE_EVENTS';
export const SELECT_YEAR = 'SELECT_YEAR';
export const START_FETCHING = 'START_FETCHING';

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

function endFetching() {
  return {
    type: END_FETCHING
  };
}

function startFetching() {
  return {
    type: START_FETCHING
  };
}

export function fetchEvents(year) {
  return dispatch => {
    dispatch(startFetching(year), requestEvents(year));
    return fetch(`/events.json?year=${year}`)
      .then(req => req.json())
      .then(json => dispatch(receiveEvents(json)))
      .then(events => dispatch(selectYear(events.year)))
      .then(() => dispatch(endFetching()));
  }
}

export function fetchEventsIfNeeded(year, nextYear) {
  return (dispatch, getState) => {
    if (!getState().fetching) {
      return dispatch(fetchEvents(year));
    }
  };
}
