import PropTypes from 'prop-types';
import React, { Component } from 'react';

export default class Picker extends Component {
  render () {
    const { value, onChange, options } = this.props;

    if (value && onChange && options) {
      return (
        <span>
          <select onChange={e => onChange(e.target.value)}
                  value={value}>
            {options.sort().reverse().map(option =>
              <option value={option} key={option}>
                {option}
              </option>)
            }
          </select>
        </span>
      );
    }

    return (<span></span>);
  }
}
