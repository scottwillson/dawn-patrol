import EventCategoryLinkRow from './EventCategoryLinkRow';
import R from 'ramda';
import React, { Component } from 'react';

export default props => {
  if (props.eventCategories.length < 2) {
    return null;
  }

  return (
    <table className="event-category-links">
      <tbody>
        {eventCategoryRows(props).map((row, index) => <EventCategoryLinkRow row={row} key={index} />)}
      </tbody>
    </table>
  );
}

function eventCategoryRows(props) {
  const rows = [];
  const sortedEventCategories = R.sortBy(R.path(['category', 'name']))(props.eventCategories);
  const firstHalf = sortedEventCategories.slice(0, (sortedEventCategories.length / 2.0 + 0.5));

  firstHalf.forEach((eventCategory, index) => {
    const rightEventCategory = sortedEventCategories[firstHalf.length + index];
    if (rightEventCategory) {
      rows.push([eventCategory, rightEventCategory])
    } else {
      rows.push([eventCategory])
    }
  });

  return rows;
}
