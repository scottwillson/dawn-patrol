import React, { Component } from 'react';
import { connect } from 'react-redux';
import { eventsFetchData } from '../actions/events';
import PropTypes from 'prop-types';

class Events extends Component {
  componentDidMount() {
    this.props.fetchData(`/events.json?year=2012`);
  }

  render() {
    if (this.props.error) {
      return <p >Sorry! There was an error loading the events: {this.props.error} < /p>;
    }

    if (this.props.isLoading) {
      return <p > Loading… < /p>;
    }

    return ( <
      ul > {
        this.props.events.map((event) => ( <
          li key = {
            event.id
          } > {
            event.name
          } <
          /li>
        ))
      } <
      /ul>
    );
  }
}

Events.propTypes = {
  fetchData: PropTypes.func.isRequired,
  events: PropTypes.array.isRequired,
  isLoading: PropTypes.bool.isRequired
};

const mapStateToProps = (state) => {
  return {
    events: state.events,
    error: state.error,
    isLoading: state.eventsIsLoading
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    fetchData: (url) => dispatch(eventsFetchData(url))
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Events);
