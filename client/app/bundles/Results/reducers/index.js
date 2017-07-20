import { combineReducers } from 'redux';
import { error, results, resultsFetching } from './results';

export default combineReducers({
  error,
  resultsFetching,
  results
});
