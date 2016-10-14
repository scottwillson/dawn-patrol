function Result(props) {
  return (
    <tr>
      <td className="hidden-sm-down place">{props.place}</td>
      <td className="hidden-sm-down name">{props.person && props.person.name}</td>
    </tr>
  );
}

Result.propTypes = {
  place: React.PropTypes.string
};
