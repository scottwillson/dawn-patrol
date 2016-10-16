function CategoryLinkRow(props) {
  return (
    <tr>
      {props.row.map(category => (
        <CategoryLink key={category.id} {...category} />
      ))}
    </tr>
  );
}
