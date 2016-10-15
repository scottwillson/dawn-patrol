class Results extends React.Component {
  constructor(props) {
    super(props);
    this.state = props.event;
    this.state.categories = [];
    this.componentWillMount = this.componentWillMount.bind(this);
  }

  render() {
    return (
      <div>
        <h2>{this.state.name}</h2>
        {this.state.categories.map(category => <Category key={category.id} {...category} />)}
      </div>
    );
  }

  componentWillMount() {
    superagent
      .get(`/events/events/${this.state.id}/results.json`)
      .end(function(err, res) {
        if (err) {
          console.error(err);
          return false;
        }
        this.setState({categories: res.body});
      }.bind(this));
  }
}
