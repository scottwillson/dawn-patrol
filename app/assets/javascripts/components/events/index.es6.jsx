Events.Index = class Index extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
    this.componentWillMount = this.componentWillMount.bind(this);
  }

  render() {
    return (
      <div>
        <AlertMessage error={this.state.error}/>
        <h2>{this.state.year} Schedule</h2>
        <Years selected={this.state.year} years={this.state.years}/>
        <Disciplines selected={this.state.discipline} disciplines={this.state.disciplines}/>
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
        this.setState(res.body);
      }.bind(this));
  }

  jsonQueryParams() {
    const params = {};

    if (query.get('discipline')) {
      params.discipline = query.get('discipline')
    }

    if (query.get('year')) {
      params.year = query.get('year')
    }

    return params;
  }
}

Events.Index.propTypes = {
  events: React.PropTypes.array.isRequired,
  year: React.PropTypes.number.isRequired
};
