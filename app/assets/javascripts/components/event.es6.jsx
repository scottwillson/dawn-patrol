class Event extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
  }

  render () {
    return (
      <tr>
        <td className="date">{moment(this.state.starts_at).format('ddd M/D')}</td>
        <td>
          <a href={`/results/event_results/${this.state.id}`}>{this.state.name}</a>
        </td>
        <td className="hidden-sm-down">{this.state.promoter_names.join('<br/>')}</td>
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
