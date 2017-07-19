import { fetching, fetchEvents, fetchEvents, selectYear } from '../actions';
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
    this.props.dispatch(fetchEvents(this.props.year));
  }

  componentWillReceiveProps(nextProps) {
    const { dispatch, year } = nextProps;
    dispatch(fetchEvents(this.props.year, year));
  }

  handleChange(nextYear) {
    this.props.dispatch(selectYear(nextYear));
  }

  render () {
    const { year, events, fetching } = this.props;
    const years = this.props.linkGroups[1].links;

    return (
      <div>
        <AlertMessage error={this.props.error}/>
        <h2>{year} Schedule</h2>
        <Picker value={year}
                onChange={this.handleChange}
                options={years} />
              {fetching && events.length === 0 &&
          <h2>Loading...</h2>
        }
        {!fetching && events.length === 0 &&
          <h2>Empty.</h2>
        }
        {events.length > 0 &&
          <div style={{ opacity: fetching ? 0.5 : 1 }}>
            <Events events={events} />
          </div>
        }
      </div>
    );
  }
}

AsyncApp.propTypes = {
  events: PropTypes.array.isRequired,
  fetching: PropTypes.bool.isRequired,
  dispatch: PropTypes.func.isRequired
};

function mapStateToProps(state) {
  const { year, fetching, events } = state;
  const linkGroups = state.events.linkGroups || [ { links: [] }, { links: [] }];

  return {
    year,
    linkGroups,
    events,
    fetching
  };
}

export default connect(mapStateToProps)(AsyncApp);
