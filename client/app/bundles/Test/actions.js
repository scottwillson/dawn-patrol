import fetch from 'isomorphic-fetch';

export const REQUEST_EVENTS = 'REQUEST_EVENTS';
export const RECEIVE_EVENTS = 'RECEIVE_EVENTS';
export const SELECT_YEAR = 'SELECT_YEAR';
export const INVALIDATE_YEAR = 'INVALIDATE_YEAR';

export function selectYear(year) {
  return {
    type: SELECT_YEAR,
    year
  };
}

export function invalidateYear(year) {
  return {
    type: INVALIDATE_YEAR,
    year
  };
}

function requestEvents(year) {
  return {
    type: REQUEST_EVENTS,
    year
  };
}

function receiveEvents(year, json) {
  return {
    type: RECEIVE_EVENTS,
    year,
    events: json.events,
    receivedAt: Date.now()
  };
}

function fetchEvents(year) {
  return dispatch => {
    dispatch(requestEvents(year));
    return fetch(`/events.json?year=${year}`)
      .then(req => req.json())
      .then(json => dispatch(receiveEvents(year, json)));
  }
}

function shouldFetchEvents(state, year) {
  const events = state.eventsByYear[year];
  if (!events) {
    return true;
  } else if (events.isFetching) {
    return false;
  } else {
    return events.didInvalidate;
  }
}

export function fetchEventsIfNeeded(year) {
  return (dispatch, getState) => {
    if (shouldFetchEvents(getState(), year)) {
      return dispatch(fetchEvents(year));
    }
  };
}
