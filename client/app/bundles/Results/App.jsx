import Container from './Container';
import React from 'react';
import ReactOnRails from 'react-on-rails';

const ResultsApp = (props, _railsContext) => (
  <Container {...props} />
);

ReactOnRails.register({ ResultsApp });
