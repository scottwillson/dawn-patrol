import React from 'react';
import { render } from '@testing-library/react';
import Events from './Events';

it('populates itself from API', () => {
  const props = [{name: ''}];
  const events = render(<Events events={props} />);
  expect(events.find('.events').text()).toEqual("1 events");
});
