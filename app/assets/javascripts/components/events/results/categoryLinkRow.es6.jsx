Events.Results.CategoryLinkRow =function CategoryLinkRow(props) {
  return (
    <tr>
      {props.row.map(category => (
        <Events.Results.CategoryLink key={category.id} {...category} />
      ))}
    </tr>
  );
}
