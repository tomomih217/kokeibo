import React from 'react';
import { render, screen } from '@testing-library/react';
import WithoutTitleCard from '../../app/javascript/components/components/WithoutTitleCard';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Card', () => {
  test('renders title and children', () => {
    const children = <div>Test Content</div>;

    render(<WithoutTitleCard>{children}</WithoutTitleCard>);

    const contentElement = screen.getByText('Test Content');

    expect(contentElement).toBeInTheDocument();
  });
});