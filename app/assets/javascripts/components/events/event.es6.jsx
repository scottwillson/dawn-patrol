Events.Event = function Event(props) {
  return (
    <tr>
      <td className="date">{moment(props.starts_at).format('ddd M/D')}</td>
      <td>
        <a href={`/events/${props.id}/results`}>{props.name}</a>
      </td>
      <td>{props.promoter_names.join('<br/>')}</td>
      <td>{props.phone}</td>
      <td>{props.discipline}</td>
      <td>{props.location}</td>
    </tr>
  );
}

Events.Event.propTypes = {
  name: React.PropTypes.string.isRequired,
  starts_at: React.PropTypes.string
};
