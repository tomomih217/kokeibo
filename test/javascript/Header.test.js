import React from 'react';
import { render, screen } from '@testing-library/react';
import Header from '../../app/javascript/components/components/Header';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Headerコンポーネント', () => {
  test('ロゴが表示されること', () => {
    render(<Header />);
    const logoElement = screen.getByRole('img', { name: /logo/i });
    expect(logoElement).toBeInTheDocument();
  });

  test('ログインボタンが表示されること', () => {
    render(<Header />);
    const loginButton = screen.getByRole('button', { name: /ログイン/i });
    expect(loginButton).toBeInTheDocument();
  });

  /*test('ログインボタンをクリックした時に適切な処理が実行されること', () => {
    // モック関数を定義
    const mockOnClick = jest.fn();
    render(<Header />);
    const loginButton = screen.getByRole('button', { name: /ログイン/i });
    loginButton.click();
    expect(mockOnClick).toHaveBeenCalledTimes(1);
  }); */
}); 
