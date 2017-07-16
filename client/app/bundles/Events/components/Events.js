import Event from './Event';
import PropTypes from 'prop-types';
import R from 'ramda';
import React, { Component } from 'react';

export default class Events extends Component {
  render () {
    return (
      <table className="table table-sm table-striped events">
        <thead className="thead-default">
          <tr>
            <th className="date">Date</th>
            <th>Name</th>
            <th className="hidden-sm-down">Promoter</th>
            <th className="hidden-sm-down">Phone</th>
            <th className="hidden-sm-down">Discipline</th>
            <th className="hidden-sm-down">Location</th>
          </tr>
        </thead>
        <tbody>
          {R.sortBy(R.prop('starts_at'))(this.props.events).map(event => <Event key={event.id} {...event} />) }
        </tbody>
      </table>
    );
  }
}

Events.propTypes = {
  events: PropTypes.array.isRequired
};
