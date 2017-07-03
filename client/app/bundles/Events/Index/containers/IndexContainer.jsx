import React from 'react';
import Index from '../components/Index';
import superagent from 'superagent';

class IndexContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
  }

  render() {
    return (
      <Index {...this.state}/>
    );
  }

  componentWillMount() {
    superagent
      .get('/events.json')
      .query({year: this.state.year})
      .end(function(err, res) {
        if (err) {
          this.setState({error: err});
          return false;
        }
        this.setState(res.body);
      }.bind(this));
  }
}

export default IndexContainer;
