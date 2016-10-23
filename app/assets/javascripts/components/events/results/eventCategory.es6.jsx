Events.Results.EventCategory = function EventCategory(props) {
  return (
    <div>
      <h3 id={`${props.slug}`}>{props.category.name}</h3>
      <table className="table table-sm table-striped results">
        <thead className="thead-default">
          <tr>
            <th className="place"></th>
            <th className="name">Name</th>
            <th className="points">Points</th>
            <th className="time">Time</th>
          </tr>
        </thead>
        <tbody>
          {R.sortBy(R.prop('numeric_place'))(props.results).map(result => <Events.Results.Result key={result.id} {...result} />)}
        </tbody>
      </table>
    </div>
  );
}
