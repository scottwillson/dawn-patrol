Results.Child = function Child(props) {
  return (
    <tr>
      <td className='starts-at'><a href={`/events/${props.id}/results`}>{moment(props.starts_at).format('dddd, MMMM D')}</a></td>
      <td><a href={`/events/${props.id}/results`}>{props.name}</a></td>
    </tr>
  );
}
