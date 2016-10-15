function Child(props) {
  return (
    <tr>
      <td className='starts-at'><a href={`/events/events/${props.id}/results`}>{moment(props.startsAt).format('dddd, MMMM D')}</a></td>
      <td><a href={`/events/events/${props.id}/results`}>{props.name}</a></td>
    </tr>
  );
}
