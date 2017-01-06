import { SET_YEAR } from '../constants'

const initialState = {
  events: [],
  link_groups: [],
  year: 2016
};

export default function update(state = initialState, action) {
  if (action.type === SET_YEAR) {
    return { year: action.year };
  }
  return state;
}
