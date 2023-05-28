import React from 'react';
import { render } from '@testing-library/react';
import Top from '../../../app/javascript/components/pages/Top';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Topコンポーネント', () => {
  it('テキストが表示されること', () => {
    const { getByText } = render(<Top />);
    const text = getByText('わが子のために、今できること');
    expect(text).toBeInTheDocument();
  });

  it('教育費シュミレーションボタンが表示されること', () => {
    const { getByText } = render(<Top />);
    const loginButton = getByText('教育費シュミレーション');
    expect(loginButton).toBeInTheDocument();
  });

  it('トップ画像が表示されること', () => {
    const { getByAltText } = render(<Top />);
    const topImage = getByAltText('top_image');
    expect(topImage).toBeInTheDocument();
  });
});
