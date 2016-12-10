import React, { PropTypes } from 'react';
import Index from './Index';
import superagent from 'superagent';

export default class Container extends React.Component {
  constructor(props) {
    super(props);
    this.state = props.event;
    this.state.eventCategories = [];
  }

  render() {
    return (
      <Index {...this.state}/>
    );
  }

  componentWillMount() {
    superagent
      .get(`/events/${this.state.id}/results.json`)
      .end(function(err, res) {
        if (err) {
          this.setState({error: err});
          return false;
        }
        this.setState({eventCategories: res.body});
      }.bind(this));
  }
}
