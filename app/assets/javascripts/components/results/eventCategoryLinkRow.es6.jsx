Results.EventCategoryLinkRow = function EventCategoryLinkRow(props) {
  return (
    <tr>
      {props.row.map(eventCategory => (
        <Results.EventCategoryLink key={eventCategory.id} {...eventCategory} />
      ))}
    </tr>
  );
}
