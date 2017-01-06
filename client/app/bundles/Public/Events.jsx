import AlertMessage from '../../components/AlertMessage';
import Event from './Events/Event';
import LinkGroups from '../../components/LinkGroups';
import R from 'ramda';
import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

class Events extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
  }

  render() {
    return (
      <div>
        <AlertMessage error={this.state.error}/>
        <h2>{this.state.year} Schedule</h2>
        <LinkGroups linkGroups={this.state.link_groups}/>
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
            {R.sortBy(R.prop('starts_at'))(this.state.events).map(event => <Event key={event.id} {...event} />) }
          </tbody>
        </table>
      </div>
    );
  }
}

// Events.defaultProps = {
//   events: [],
//   link_groups: []
// };
//
// Events.propTypes = {
//   events: React.PropTypes.array.isRequired,
//   link_groups: React.PropTypes.array.isRequired,
//   year: React.PropTypes.number.isRequired
// };

export default connect(
  state => ({
    events: state.events,
    link_groups: state.link_groups,
    year: state.year
  })
)(Events);
