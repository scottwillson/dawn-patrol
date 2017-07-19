import React, { Component } from 'react';
import { connect } from 'react-redux';
import { setYear } from '../actions/events';
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
                options={[]} />
        <ul> {
          this.props.events.map((event) => ( <
            li key = {
              event.id
            } > {
              event.name
            } <
            /li>
          ))
        } </ul>
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
    year: state.year
  };
};

const mapDispatchToProps = dispatch => {
  return {
    yearChanged: year => dispatch(setYear(year))
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Events);
