function Children(props) {
  return (
    <table>
      <tbody>
        {props.children.map(child => <Child key={child.id} {...child} />)}
      </tbody>
    </table>
  );
}
