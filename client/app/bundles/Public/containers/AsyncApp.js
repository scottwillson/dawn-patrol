import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { selectYear, fetchEventsIfNeeded } from '../actions';
import Picker from '../components/Picker';
import Events from '../components/Events';

class AsyncApp extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleRefreshClick = this.handleRefreshClick.bind(this);
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

  handleRefreshClick(e) {
    e.preventDefault();

    const { dispatch, selectedYear } = this.props;
    dispatch(fetchEventsIfNeeded(selectedYear));
  }

  render () {
    const { selectedYear, events, isFetching, lastUpdated } = this.props;
    return (
      <div>
        <Picker value={selectedYear}
                onChange={this.handleChange}
                options={['2017', '2016', '2015', '2006']} />
        <p>
          {lastUpdated &&
            <span>
              Last updated at {new Date(lastUpdated).toLocaleTimeString()}.
              {' '}
            </span>
          }
          {!isFetching &&
            <a href='#'
               onClick={this.handleRefreshClick}>
              Refresh
            </a>
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

  return {
    selectedYear,
    events,
    isFetching,
    lastUpdated
  };
}

export default connect(mapStateToProps)(AsyncApp);
