function Year(props) {
  return (
    <li className={props.liClassName}>
      <a className={className(props)} href={`?year=${props.year}`}>{props.year}</a>
    </li>
  );
}

function className(props) {
  if (props.selected === props.year) {
    return `nav-link active`;
  }
  return 'nav-link';
}
