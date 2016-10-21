Events.Results.CategoryLink =function CategoryLink(props) {
  return (
    <td><a href={`#event-category-${props.id}`} data-turbolinks="false">{props.category.name}</a></td>
  );
}
