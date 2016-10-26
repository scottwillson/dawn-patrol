function Discipline(props) {
  return (
    <li className={props.liClassName}>
      <a className={className(props)} href={`?discipline=${props.discipline}`}>{props.discipline}</a>
    </li>
  );
}

function className(props) {
  if (props.selected === props.discipline) {
    return `nav-link active`;
  }
  return 'nav-link';
}
