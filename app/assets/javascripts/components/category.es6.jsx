function Category(props) {
  return (
    <div>
      <h3>{props.category.name}</h3>
      <table className="table table-sm table-striped results">
        <thead className="thead-default">
          <tr>
            <th className="place"></th>
            <th className="name"></th>
          </tr>
        </thead>
        <tbody>
          {R.sortBy(R.prop('numeric_place'))(props.results).map(result => <Result key={result.id} {...result} />)}
        </tbody>
      </table>
    </div>
  );
}
