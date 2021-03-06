import './App.css';
import Events from './Events.js';
import React, { Component } from 'react';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      events: props.events || []
    };
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>Dawn Patrol</h2>
        </div>
        <Events events={this.state.events} />
      </div>
    );
  }

  componentDidMount() {
    this.fetchEvents();
  }

  fetchEvents = () => fetch('/index.json')
    .then(response => {
      if (!response.ok) {
        throw Error(response.statusText);
      }
      return response.json();
    })
    .then(json => this.setState({events: json}))
}

export default App;
