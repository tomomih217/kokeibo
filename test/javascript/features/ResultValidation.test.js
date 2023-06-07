import React from 'react';
import { render, screen } from '@testing-library/react';
import ResultValidation from '../../../app/javascript/components/features/ResultValidation';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('ResultValidation', () => {
  test('入力が完全ではない場合、メッセージが表示されること', () => {
    const selectedValues = {
      age: '18',
      nurserySchool: '',
      kindergarten: '',
      primarySchool: '',
      juniorHighSchool: '',
      highSchool: '',
      university: '',
      livingAloneFunds: ''
    };

    render(<ResultValidation selectedValues={selectedValues} />);
    const messageElement = screen.getByText('入力が完全ではありません');
    expect(messageElement).toBeInTheDocument();
  });

  test('入力が完全な場合、メッセージが表示されないこと', () => {
    const selectedValues = {
      age: '18',
      nurserySchool: 'public',
      kindergarten: 'public',
      primarySchool: 'public',
      juniorHighSchool: 'public',
      highSchool: 'public',
      university: 'publicArts',
      livingAloneFunds: '50000'
    };

    render(<ResultValidation selectedValues={selectedValues} />);
    const messageElement = screen.queryByText('入力が完全ではありません');
    expect(messageElement).toBeNull();
  });
});
