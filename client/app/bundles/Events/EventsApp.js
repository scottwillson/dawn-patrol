import React, { Component } from 'react';
import {render} from 'react-dom';
import {Provider} from 'react-redux';
import configureStore from './store/configureStore';
import ReactOnRails from 'react-on-rails';
import { setYear } from './actions/events';

import Events from './components/Events';

const store = configureStore();
store.dispatch(setYear(null));

export default class EventsApp extends Component {
  render() {
    return (
      <Provider store={store}>
        <Events/>
      </Provider>
    );
  }
}

ReactOnRails.register({EventsApp});
