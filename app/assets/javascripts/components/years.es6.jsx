function Years(props) {
  return (
    <div>
      <div className="hidden-md-up years">
        <button className="btn btn-secondary" type="button" data-toggle="collapse" data-target="#years" aria-label="Toggle years">
          {props.selected}
        </button>
        <ul className="collapse list-group" id="years">
          {props.years.sort().reverse().map(year => <Year selected={props.selected} key={year} year={year} liClassName="list-group-item"/>)}
        </ul>
      </div>
      <div className="hidden-sm-down pills">
        <ul className="nav nav-pills">
          {props.years.sort().reverse().map(year => <Year selected={props.selected} key={year} year={year} liClassName="nav-item" />)}
        </ul>
      </div>
    </div>
  );
}
