import React from 'react';

const AlertMessage = props => {
  if (!props.error) {
    return null;
  }

  return (
    <div className="alert alert-danger" role="alert">
      {props.error.message}
    </div>
  );
};

export default AlertMessage;
