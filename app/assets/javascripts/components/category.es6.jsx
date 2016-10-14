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
          {props.results.map(result => <Result key={result.id} {...result} />)}
        </tbody>
      </table>
    </div>
  );
}
