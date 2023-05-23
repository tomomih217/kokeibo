import React from 'react';
import { render, screen } from '@testing-library/react';
import Text from '../../app/javascript/components/Text';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Text Component', () => {
  test('renders text with the specified size and color', () => {
    const size = 'lg';
    const color = 'blue';
    const text = 'This is a test text';

    render(<Text size={size} color={color}>{text}</Text>);

    const textElement = screen.getByText(text);
    expect(textElement).toBeInTheDocument();
    expect(textElement).toHaveClass(`text-${size}`);
    expect(textElement).toHaveClass(`text-${color}`);
  });
});
