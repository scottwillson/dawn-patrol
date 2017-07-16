import AlertMessage from '../../../../components/AlertMessage';
import Event from './Event';
import LinkGroups from '../../../../components/LinkGroups';
import R from 'ramda';
import React, { Component } from 'react';

const Index = props => (
  <div>
    <AlertMessage error={props.error}/>
    <h2>{props.year} Schedule</h2>
    <LinkGroups linkGroups={props.link_groups}/>
    <table className="table table-sm table-striped events">
      <thead className="thead-default">
        <tr>
          <th className="date">Date</th>
          <th>Name</th>
          <th className="hidden-sm-down">Promoter</th>
          <th className="hidden-sm-down">Phone</th>
          <th className="hidden-sm-down">Discipline</th>
          <th className="hidden-sm-down">Location</th>
        </tr>
      </thead>
      <tbody>
        {R.sortBy(R.prop('starts_at'))(props.events).map(event => <Event key={event.id} {...event} />) }
      </tbody>
    </table>
  </div>
);

export default Index;
