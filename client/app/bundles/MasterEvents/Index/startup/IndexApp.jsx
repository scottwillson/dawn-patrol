import IndexContainer from '../containers/IndexContainer';
import React from 'react';
import ReactOnRails from 'react-on-rails';

const IndexApp = (props, _railsContext) => (
  <IndexContainer {...props} />
);

ReactOnRails.register({ IndexApp });
