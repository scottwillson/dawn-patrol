Events.Results.CategoryLink =function CategoryLink(props) {
  return (
    <td><a href={`#${props.slug}`} data-turbolinks="false">{props.category.name}</a></td>
  );
}
