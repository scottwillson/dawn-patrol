Results.EventCategoryLink =function EventCategoryLink(props) {
  return (
    <td><a href={`#${props.slug}`} data-turbolinks="false">{props.category.name}</a></td>
  );
}
