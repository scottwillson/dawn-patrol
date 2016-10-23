Events.Index = class Index extends React.Component {
  constructor(props) {
    super(props);
    this.state = {events: [], year: props.year};
    this.componentWillMount = this.componentWillMount.bind(this);
  }

  render() {
    return (
      <div>
        <AlertMessage error={this.state.error}/>
        <h2>{this.state.year} Schedule</h2>
        <table className="table table-sm table-striped events">
          <thead className="thead-default">
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
            {this.state.events.map(event => <Events.Event key={event.id} {...event} />) }
          </tbody>
        </table>
      </div>
    );
  }

  componentWillMount() {
    superagent
      .get('/events.json')
      .query(this.jsonQueryParams())
      .end(function(err, res) {
        if (err) {
          this.setState({error: err});
          return false;
        }
        this.setState({events: res.body});
      }.bind(this));
  }

  jsonQueryParams() {
    if (query.get('year')) {
      return {year: query.get('year')}
    }
    return {};
  }
}
