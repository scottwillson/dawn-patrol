export function error(state = false, action) {
  switch (action.type) {
    case 'ERROR':
      return action.error;

    default:
      return state;
  }
}

export function resultsFetching(state = false, action) {
  switch (action.type) {
    case 'RESULTS_FETCHING':
      return action.isLoading;

    default:
      return state;
  }
}

export function results(state = [], action) {
  switch (action.type) {
    case 'RESULTS_FETCHED':
      return action.eventCategories;

    default:
      return state;
  }
}
