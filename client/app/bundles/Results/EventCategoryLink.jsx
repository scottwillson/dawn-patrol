import React, { Component } from 'react';

export default props => (
  <td><a href={`#${props.slug}`} data-turbolinks="false">{props.category.name}</a></td>
);
