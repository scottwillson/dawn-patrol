import { fetchEvents } from './actions/events';
import Events from './components/Events';
import React, { Component } from 'react';
import ReactOnRails from 'react-on-rails';
import {Provider} from 'react-redux';
import configureStore from './store/configureStore';

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
