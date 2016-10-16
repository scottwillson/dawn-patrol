function Result(props) {
  return (
    <tr>
      <td className="hidden-sm-down place">{props.place}</td>
      <td className="hidden-sm-down name">{props.person && props.person.name}</td>
      <td className="hidden-sm-down points">{props.points}</td>
      <td className="hidden-sm-down time">{props.time}</td>
    </tr>
  );
}

Result.propTypes = {
  place: React.PropTypes.string
};
