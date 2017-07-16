import React, { PropTypes, Component } from 'react';

export default class Events extends Component {
  render () {
    return (
      <ul>
        {this.props.events.map((event, i) =>
          <li key={i}>{event.name}</li>
        )}
      </ul>
    );
  }
}

Events.propTypes = {
  events: PropTypes.array.isRequired
};
