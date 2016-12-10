import moment from 'moment';
import R from 'ramda';
import React, { Component, PropTypes } from 'react';

export default props => (
  <tr>
    <td className='starts-at'><a href={`/events/${props.id}/results`}>{moment(props.starts_at).format('dddd, MMMM D')}</a></td>
    <td><a href={`/events/${props.id}/results`}>{props.name}</a></td>
  </tr>
);
