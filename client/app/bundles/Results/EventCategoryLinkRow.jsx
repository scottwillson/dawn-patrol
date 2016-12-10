import EventCategoryLink from './EventCategoryLink';
import React, { Component, PropTypes } from 'react';

export default props => (
  <tr>
    {props.row.map(eventCategory => (
      <EventCategoryLink key={eventCategory.id} {...eventCategory} />
    ))}
  </tr>
);
