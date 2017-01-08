import Events from './Events';
import React from 'react';
import { render } from 'react-dom'
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import { Router, Route, browserHistory } from 'react-router';
import { syncHistoryWithStore, routerReducer } from 'react-router-redux';
import * as reducers from './reducers';
import { createStore, combineReducers } from 'redux';

const PublicApp = (_props, _railsContext) => {
  const reducer = combineReducers({
    ...reducers,
    routing: routerReducer
  });

  const store = createStore(reducer);
  const history = syncHistoryWithStore(browserHistory, store);

  console.log('store.getState()', store.getState());

  return (
    <Provider store={store}>
      <Router history={history}>
        <Route path="events" component={Events}/>
      </Router>
    </Provider>
  );
};

ReactOnRails.register({ PublicApp });
