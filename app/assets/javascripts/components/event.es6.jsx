class Event extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
  }

  render () {
    return (
      <tr>
        <td className="date">Sun 11/27</td>
        <td>
          <a href={`/results/event_results/${this.state.id}`}>{this.state.name}</a>
        </td>
        <td className="hidden-sm-down">{this.state.promoter_name}</td>
        <td className="hidden-sm-down">{this.state.phone}</td>
        <td className="hidden-sm-down">{this.state.discipline}</td>
        <td className="hidden-sm-down">{this.state.location}</td>
      </tr>
    );
  }
}

Event.propTypes = {
  name: React.PropTypes.string
};
