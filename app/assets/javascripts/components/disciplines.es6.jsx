function Disciplines(props) {
  return (
    <div>
      <div className="hidden-md-up disciplines">
        <button className="btn btn-secondary" type="button" data-toggle="collapse" data-target="#disciplines" aria-label="Toggle disciplines">
          {props.selected}
        </button>
        <ul className="collapse list-group" id="disciplines">
          {props.disciplines.sort().map(discipline => <Discipline selected={props.selected} key={discipline} discipline={discipline} liClassName="list-group-item"/>)}
        </ul>
      </div>
      <div className="hidden-sm-down pills">
        <ul className="nav nav-pills">
          {props.disciplines.sort().map(discipline => <Discipline selected={props.selected} key={discipline} discipline={discipline} liClassName="nav-item" />)}
        </ul>
      </div>
    </div>
  );
}
