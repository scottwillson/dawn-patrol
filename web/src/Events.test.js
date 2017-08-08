import React from 'react';
import { mount } from 'enzyme';
import Events from './Events';

it('populates itself from API', () => {
  const events = [{name: ''}];
  const app = mount(<Events events={events} />);
  expect(app.find('.events').text()).toEqual("1 events");
});
