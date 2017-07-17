export function error(error) {
  return {
    type: 'ERROR',
    error: error
  };
}

export function eventsIsLoading(bool) {
  return {
    type: 'EVENTS_IS_LOADING',
    isLoading: bool
  };
}

export function eventsFetchDataSuccess(events) {
  return {
    type: 'EVENTS_FETCH_DATA_SUCCESS',
    events
  };
}

export function eventsFetchData(url) {
  return (dispatch) => {
    dispatch(exports.eventsIsLoading(true));

    fetch(url)
      .then((response) => {
        if (!response.ok) {
          throw Error(response.statusText);
        }

        dispatch(exports.eventsIsLoading(false));

        return response;
      })
      .then((response) => response.json())
      .then(json => dispatch(exports.eventsFetchDataSuccess(json.events)))
      .catch(error => dispatch(exports.error(error)));
  };
}
