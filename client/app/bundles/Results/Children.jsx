import Child from './Child';
import R from 'ramda';
import React, { Component, PropTypes } from 'react';

export default props => (
  <table>
    <tbody>
      {R.sortBy(R.prop('starts_at'))(props.children).map(child => <Child key={child.id} {...child} />)}
    </tbody>
  </table>
);
