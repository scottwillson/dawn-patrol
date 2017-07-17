export function error(state = false, action) {
  switch (action.type) {
    case 'ERROR':
      return action.error;

    default:
      return state;
  }
}

export function eventsIsLoading(state = false, action) {
  switch (action.type) {
    case 'EVENTS_IS_LOADING':
      return action.isLoading;

    default:
      return state;
  }
}

export function events(state = [], action) {
  switch (action.type) {
    case 'EVENTS_FETCH_DATA_SUCCESS':
      return action.events;

    default:
      return state;
  }
}
