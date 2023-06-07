import React from 'react';
import { render, screen } from '@testing-library/react';
import Card from '../../../app/javascript/components/components/Card';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Card', () => {
  test('renders title and children', () => {
    const title = 'Sample Card';
    const children = <p>Sample Content</p>;
    const widthSize = '1/2';

    render(<Card title={title} widthSize={widthSize}>{children}</Card>);

    // カードの要素が表示されていることを確認
    const cardElement = screen.getByText(title).parentElement;
    expect(cardElement).toBeInTheDocument();
    expect(cardElement).toHaveClass(`w-${widthSize}`);

    // タイトルが表示されていることを確認
    const titleElement = screen.getByText(title);
    expect(titleElement).toBeInTheDocument();

    // コンテンツが表示されていることを確認
    const contentElement = screen.getByText('Sample Content');
    expect(contentElement).toBeInTheDocument();
  });
});
