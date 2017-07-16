import 'babel-polyfill';

import React from 'react';
import ReactDOM from 'react-dom';
import EventsRoot from './containers/EventsRoot';
import ReactOnRails from 'react-on-rails';

ReactOnRails.register({ EventsRoot });
