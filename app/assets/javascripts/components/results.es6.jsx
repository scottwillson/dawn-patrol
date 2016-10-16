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
        {this.cityState(this.state.city, this.state.state)}
        {this.parent(this.state.parent)}
        <div className='starts-at'>{this.dates(this.state.starts_at, this.state.children)}</div>
        <Children children={this.state.children}/>
        <CategoryLinks categories={this.state.categories}/>
        {this.state.categories.map(category => <Category key={category.id} {...category} />)}
        <div className='updated-at'>Updated {moment(this.state.updatedAt).format('MMMM D, YYYY')}</div>
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

  cityState(city, state) {
    if (city || state) {
      return (<div className='city-state'>{[city, state].join(', ')}</div>);
    }
    return null;
  }

  dates(startsAt, children) {
    if (children.length < 2) {
      return this.singleDay(startsAt);
    }

    const startsAts = children.map(c => c.starts_at).sort();
    const firstStartsAt = moment(startsAts[0]);
    const lastStartsAt = moment(startsAts[startsAts.length - 1]);

    if (firstStartsAt.diff(lastStartsAt) == 0) {
      return this.singleDay(startsAt);
    }

    return `${firstStartsAt.format('MMMM D')} to ${lastStartsAt.format('MMMM D, YYYY')}`;
  }

  singleDay(startsAt) {
    return moment(startsAt).format('MMMM D, YYYY');
  }

  parent(parent) {
    if (parent) {
      return(<div>Part of the <a href={`/events/events/${parent.id}/results`}>{parent.name}</a></div>);
    }
    return null;
  }
}
