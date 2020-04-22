import React from 'react';
import { render } from '@testing-library/react';
import Events from './Events';

it('populates itself from API', () => {
  const props = [{name: ''}];
  const { getByText } = render(<Events events={props} />);
  const events = getByText(/1 events/i);
  expect(events).toBeInTheDocument();
});
