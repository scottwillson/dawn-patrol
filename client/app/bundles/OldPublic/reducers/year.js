import { SET_YEAR } from '../constants'

const initialState = 2016;

export default function update(state = initialState, action) {
  if (action.type === SET_YEAR) {
    return action.year;
  }
  return state;
}
