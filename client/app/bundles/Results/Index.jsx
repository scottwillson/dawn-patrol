import AlertMessage from '../../components/AlertMessage';
import Children from './Children';
import EventCategory from './EventCategory';
import EventCategoryLinks from './EventCategoryLinks';
import LinkGroups from '../../components/LinkGroups';
import moment from 'moment';
import R from 'ramda';
import React, { Component } from 'react';

export default class Index extends React.Component {
  render() {
    return (
      <div>
        <div className="text-sm-center">
          <AlertMessage error={this.props.error}/>
          <h2>{this.props.name}</h2>
          {this.cityState(this.props.city, this.props.state)}
          {this.parent(this.props.parent)}
          <div className='starts-at'>{this.dates(this.props.starts_at, this.props.children)}</div>
          <Children children={this.props.children}/>
          <EventCategoryLinks eventCategories={this.props.eventCategories}/>
        </div>
        {this.props.eventCategories.map(eventCategory => <EventCategory key={eventCategory.id} {...eventCategory} />)}
        <div className='updated-at'>Updated {moment(this.props.updatedAt).format('MMMM D, YYYY')}</div>
      </div>
    );
  }

  cityState(city, state) {
    if (city || state) {
      return (<div className='city-state'>{[city, state].join(', ')}</div>);
    }
    return null;
  }

  dates(startsAt, children) {
    if (children.length < 2) {
      return this.singleDay(startsAt);
    }

    const startsAts = children.map(c => c.starts_at).sort();
    const firstStartsAt = moment(startsAts[0]);
    const lastStartsAt = moment(startsAts[startsAts.length - 1]);

    if (firstStartsAt.diff(lastStartsAt) === 0) {
      return this.singleDay(startsAt);
    }

    return `${firstStartsAt.format('MMMM D')} to ${lastStartsAt.format('MMMM D, YYYY')}`;
  }

  singleDay(startsAt) {
    return moment(startsAt).format('MMMM D, YYYY');
  }

  parent(parent) {
    if (parent) {
      return(<div>Part of the <a href={`/events/${parent.id}/results`}>{parent.name}</a></div>);
    }
    return null;
  }
}
