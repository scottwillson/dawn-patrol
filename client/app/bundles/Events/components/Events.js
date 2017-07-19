import R from 'ramda';
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { fetchEvents } from '../actions/events';
import Event from '../components/Event';
import Picker from '../components/Picker';
import PropTypes from 'prop-types';
import { year } from '../actions/events';

class Events extends Component {
  render() {
    if (this.props.error) {
      return <p >Sorry! There was an error loading the events: {this.props.error} < /p>;
    }

    if (this.props.isLoading) {
      return <p > Loading… < /p>;
    }

    return (
      <div>
        <h1>{this.props.year} Schedule</h1>
        <Picker value={this.props.year}
                onChange={this.props.yearChanged}
                options={this.props.years} />

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
      </div>
    );
  }
}

Events.propTypes = {
  events: PropTypes.array.isRequired,
  isLoading: PropTypes.bool.isRequired,
  year: PropTypes.number,
  yearChanged: PropTypes.func.isRequired
};

const mapStateToProps = (state) => {
  return {
    events: state.events,
    error: state.error,
    isLoading: state.eventsIsLoading,
    year: state.year,
    years: state.years
  };
};

const mapDispatchToProps = dispatch => {
  return {
    yearChanged: year => dispatch(fetchEvents(year))
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Events);
