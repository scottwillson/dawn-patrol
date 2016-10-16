function AlertMessage(props) {
  if (!props.error) {
    return null;
  }

  return (
    <div className="alert alert-danger" role="alert">
      {props.error.message}
    </div>
  );
}
