import React from 'react';
import { render } from '@testing-library/react';
import Container from '../../../app/javascript/components/components/Container';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Containerコンポーネント', () => {
  test('正しいタイトルが表示されること', () => {
    const title = 'テストタイトル';
    const { getByText } = render(<Container title={title} />);
    const titleElement = getByText(title);
    expect(titleElement).toBeInTheDocument();
  });

  test('子要素が正しく表示されること', () => {
    const childText = 'テストコンテンツ';
    const { getByText } = render(
      <Container title="テストタイトル">
        <div>{childText}</div>
      </Container>
    );
    const childElement = getByText(childText);
    expect(childElement).toBeInTheDocument();
  });
});
