function Event(props) {
  return (
    <tr>
      <td className="date">{moment(props.starts_at).format('ddd M/D')}</td>
      <td>
        <a href={`/events/events/${props.id}/results`}>{props.name}</a>
      </td>
      <td className="hidden-sm-down">{props.promoter_names.join('<br/>')}</td>
      <td className="hidden-sm-down">{props.phone}</td>
      <td className="hidden-sm-down">{props.discipline}</td>
      <td className="hidden-sm-down">{props.location}</td>
    </tr>
  );
}

Event.propTypes = {
  name: React.PropTypes.string
};
