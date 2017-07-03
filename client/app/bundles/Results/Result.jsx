import React, { Component } from 'react';

export default props => (
  <tr>
    <td className="place">{props.place}</td>
    <td className="name">{props.person && props.person.name}</td>
    <td className="points">{props.points}</td>
    <td className="time">{props.time}</td>
  </tr>
);
