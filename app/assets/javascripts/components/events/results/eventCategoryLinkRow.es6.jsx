Events.Results.EventCategoryLinkRow = function EventCategoryLinkRow(props) {
  return (
    <tr>
      {props.row.map(eventCategory => (
        <Events.Results.EventCategoryLink key={eventCategory.id} {...eventCategory} />
      ))}
    </tr>
  );
}
