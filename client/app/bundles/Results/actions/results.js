import fetch from "isomorphic-fetch";

export function error(error) {
  return {
    type: 'ERROR',
    error: error
  };
}

export function resultsFetching(bool) {
  return {
    type: 'RESULTS_FETCHING',
    isLoading: bool
  };
}

export function resultsFetched(json) {
  return {
    type: 'RESULTS_FETCHED',
    eventCategories: json.eventCategories
  };
}

export function fetchEvents(id) {
  const url = `/events/${id}/results.json`;

  return (dispatch) => {
    dispatch(exports.resultsFetching(true));

    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw Error(response.statusText);
        }

        dispatch(exports.resultsFetching(false));

        return response;
      })
      .then(response => response.json())
      .then(json => dispatch(exports.resultsFetched(json)))
      .catch(error => dispatch(exports.error(error)));
  };
}
