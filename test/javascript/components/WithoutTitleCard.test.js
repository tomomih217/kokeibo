import React from 'react';
import { render, screen } from '@testing-library/react';
import WithoutTitleCard from '../../../app/javascript/components/components/WithoutTitleCard';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Card', () => {
  test('renders title and children', () => {
    const widthSize = '1/2';
    const bgColor = 'amber-card';
    const borderColor = 'amber-dark';
    const children = <div>Test Content</div>;

    render(<WithoutTitleCard widthSize={widthSize} bgColor={bgColor} borderColor={borderColor}>{children}</WithoutTitleCard>);

    //要素が表示されること
    const cardElement = screen.getByText('Test Content').parentElement.parentElement;
    expect(cardElement).toBeInTheDocument();
    expect(cardElement).toHaveClass(`w-${widthSize}`);
    expect(cardElement).toHaveClass(`bg-${bgColor}`);
    expect(cardElement).toHaveClass(`border-${borderColor}`);

    //コンテンツが表示されること
    const contentElement = screen.getByText('Test Content');
    expect(contentElement).toBeInTheDocument();
  });
});