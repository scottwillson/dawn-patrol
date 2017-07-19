import { fetchEvents } from './actions/events';
import React, { Component } from 'react';
import {render} from 'react-dom';
import ReactOnRails from 'react-on-rails';
import {Provider} from 'react-redux';
import configureStore from './store/configureStore';

import Events from './components/Events';

const store = configureStore();
store.dispatch(fetchEvents(null));

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
