import React from 'react';
import { render, screen } from '@testing-library/react';
import Label from '../../../app/javascript/components/components/Label';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Label Component', () => {
  test('renders Label with the specified size and color', () => {
    const size = 'lg';
    const color = 'blue';
    const label = 'This is a test label';

    render(<Label size={size} color={color}>{label}</Label>);

    const labelElement = screen.getByText(label);
    expect(labelElement).toBeInTheDocument();
    expect(labelElement).toHaveClass(`text-${size}`);
    expect(labelElement).toHaveClass(`text-${color}`);
  });
});