class Events extends React.Component {
  constructor(props) {
    super(props);
    this.state = {events: []};
    this.componentWillMount = this.componentWillMount.bind(this);
  }

  render() {
    return (
      <div>
        <h2>2016 Schedule</h2>
        <table className="table table-sm events">
          <thead>
            <tr>
              <th className="date">Date</th>
              <th>Name</th>
              <th className="hidden-sm-down">Promoter</th>
              <th className="hidden-sm-down">Phone</th>
              <th className="hidden-sm-down">Discipline</th>
              <th className="hidden-sm-down">Location</th>
            </tr>
          </thead>
          <tbody>
            {this.state.events.map(event => <Event key={event.id} {...event} />) }
          </tbody>
        </table>
      </div>
    );
  }

  componentWillMount() {
    superagent
      .get('/events/events.json')
      .end(function(err, res) {
        this.setState({events: res.body});
      }.bind(this));
  }
}
