import { fetchEvents } from './actions/results';
import Event from './components/Event';
import React, { Component } from 'react';
import ReactOnRails from 'react-on-rails';
import {Provider} from 'react-redux';
import configureStore from './store/configureStore';

const store = configureStore();
store.dispatch(fetchEvents());

export default class ResultsApp extends Component {
  render() {
    return (
      <Provider store={store}>
        <Event/>
      </Provider>
    );
  }
}

ReactOnRails.register({ResultsApp});
