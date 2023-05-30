import React from 'react';
import { render, screen } from '@testing-library/react';
import Card from '../../app/javascript/components/components/Card';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Card', () => {
  test('renders title and children', () => {
    const title = 'Test Title';
    const children = <div>Test Content</div>;

    render(<Card title={title}>{children}</Card>);

    const titleElement = screen.getByText(title);
    const contentElement = screen.getByText('Test Content');

    expect(titleElement).toBeInTheDocument();
    expect(contentElement).toBeInTheDocument();
  });
});
