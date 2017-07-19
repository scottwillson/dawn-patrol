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

export function year(state = null, action) {
  switch (action.type) {
    case 'EVENTS_FETCH_DATA_SUCCESS':
      return action.year;

    default:
      return state;
  }
}

export function years(state = null, action) {
  switch (action.type) {
    case 'EVENTS_FETCH_DATA_SUCCESS':
      return action.years;

    default:
      return state;
  }
}
