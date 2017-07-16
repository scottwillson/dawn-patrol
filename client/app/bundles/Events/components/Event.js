import moment from 'moment';
import PropTypes from 'prop-types';
import React, { Component } from 'react';

export default class Event extends Component {
  render () {
    return (
      <tr>
        <td className="date">{moment(this.props.starts_at).format('ddd M/D')}</td>
        <td>
          {this.props.name}
        </td>
        <td className="hidden-sm-down">{this.props.promoter_names.join('<br/>')}</td>
        <td className="hidden-sm-down">{this.props.phone}</td>
        <td className="hidden-sm-down">{this.props.discipline}</td>
        <td className="hidden-sm-down">{this.props.location}</td>
      </tr>
    );
  }
}

Event.propTypes = {
  name: PropTypes.string.isRequired,
  starts_at: PropTypes.string
};
