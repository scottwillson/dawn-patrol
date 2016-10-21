Events.Results.Children =function Children(props) {
  return (
    <table>
      <tbody>
        {R.sortBy(R.prop('starts_at'))(props.children).map(child => <Events.Results.Child key={child.id} {...child} />)}
      </tbody>
    </table>
  );
}
