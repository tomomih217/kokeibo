import React from 'react';
import { render } from '@testing-library/react';
import Footer from '../../app/javascript/components/components/Footer';
import { toBeInTheDocument } from '@testing-library/jest-dom';


describe('Footer', () => {
  test('renders footer links correctly', () => {
    // レンダリング
    const { getByText } = render(<Footer />);

    // リンクテキストを検証
    expect(getByText('プライバシーポリシー')).toBeInTheDocument();
    expect(getByText('利用規約')).toBeInTheDocument();
    expect(getByText('お問い合わせ')).toBeInTheDocument();
  });
});
