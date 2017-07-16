import { fetchEventsIfNeeded, selectYear } from '../actions';
import AlertMessage from '../../../components/AlertMessage';
import Events from '../components/Events';
import Picker from '../components/Picker';
import PropTypes from 'prop-types';
import React, { Component } from 'react';
import { connect } from 'react-redux';

class AsyncApp extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  componentDidMount() {
    const { dispatch, year } = this.props;
    dispatch(fetchEventsIfNeeded(year));
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.year !== this.props.year) {
      const { dispatch, year } = nextProps;
      dispatch(fetchEventsIfNeeded(year));
    }
  }

  handleChange(nextYear) {
    this.props.dispatch(selectYear(nextYear));
  }

  render () {
    const { year, events, isFetching } = this.props;
    const years = this.props.linkGroups[1].links;

    return (
      <div>
        <AlertMessage error={this.props.error}/>
        <h2>{year} Schedule</h2>
        <Picker value={year}
                onChange={this.handleChange}
                options={years} />
        {isFetching && events.length === 0 &&
          <h2>Loading...</h2>
        }
        {!isFetching && events.length === 0 &&
          <h2>Empty.</h2>
        }
        {events.length > 0 &&
          <div style={{ opacity: isFetching ? 0.5 : 1 }}>
            <Events events={events} />
          </div>
        }
      </div>
    );
  }
}

AsyncApp.propTypes = {
  events: PropTypes.array.isRequired,
  isFetching: PropTypes.bool.isRequired,
  dispatch: PropTypes.func.isRequired
};

function mapStateToProps(state) {
  const { year } = state;
  const { events, isFetching } = state.events || { events: [], isFetching: true };
  const linkGroups = state.events.linkGroups || [ { links: [] }, { links: [] }];

  return {
    year,
    linkGroups,
    events,
    isFetching
  };
}

export default connect(mapStateToProps)(AsyncApp);
