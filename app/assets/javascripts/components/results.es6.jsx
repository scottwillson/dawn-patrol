class Results extends React.Component {
  constructor(props) {
    super(props);
    this.state = {eventId: props.event_id, categories: []};
    this.componentWillMount = this.componentWillMount.bind(this);
  }

  render() {
    return (
      <div>
        <h2>Results</h2>
        {this.state.categories.map(category => <Category key={category.id} {...category} />)}
      </div>
    );
  }

  componentWillMount() {
    superagent
      .get(`/events/events/${this.state.eventId}/results.json`)
      .end(function(err, res) {
        if (err) {
          console.error(err);
          return false;
        }
        this.setState({categories: res.body.categories});
      }.bind(this));
  }
}
