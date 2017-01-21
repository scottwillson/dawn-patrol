import { SET_YEAR } from '../constants'

export function setYear(year) {
  return {
    type: SET_YEAR,
    year: year
  }
}
