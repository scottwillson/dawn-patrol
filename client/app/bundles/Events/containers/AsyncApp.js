import { selectYear, fetchEventsIfNeeded } from '../actions';
import AlertMessage from '../../../components/AlertMessage';
import Events from '../components/Events';
import Picker from '../components/Picker';
import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

class AsyncApp extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  componentDidMount() {
    const { dispatch, selectedYear } = this.props;
    dispatch(fetchEventsIfNeeded(selectedYear));
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.selectedYear !== this.props.selectedYear) {
      const { dispatch, selectedYear } = nextProps;
      dispatch(fetchEventsIfNeeded(selectedYear));
    }
  }

  handleChange(nextYear) {
    this.props.dispatch(selectYear(nextYear));
  }

  render () {
    const { selectedYear, events, isFetching, lastUpdated } = this.props;
    const years = this.props.linkGroups[1].links;

    return (
      <div>
        <AlertMessage error={this.props.error}/>
        <h2>{selectedYear} Schedule</h2>
        <Picker value={selectedYear}
                onChange={this.handleChange}
                options={years} />
        <p>
          {lastUpdated &&
            <span>
              Last updated at {new Date(lastUpdated).toLocaleTimeString()}.
              {' '}
            </span>
          }
        </p>
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
  selectedYear: PropTypes.string.isRequired,
  events: PropTypes.array.isRequired,
  isFetching: PropTypes.bool.isRequired,
  lastUpdated: PropTypes.number,
  dispatch: PropTypes.func.isRequired
};

function mapStateToProps(state) {
  const { selectedYear, lastUpdated } = state;
  const { events, isFetching } = state.events || { events: [], isFetching: true };
  const linkGroups = state.events.linkGroups || [ { links: [] }, { links: [] }];

  return {
    selectedYear,
    linkGroups,
    events,
    isFetching,
    lastUpdated
  };
}

export default connect(mapStateToProps)(AsyncApp);
