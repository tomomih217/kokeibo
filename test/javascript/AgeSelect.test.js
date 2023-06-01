import React from 'react';
import { render, fireEvent, getByDisplayValue } from '@testing-library/react';
import AgeSelect from '../../app/javascript/components/components/AgeSelect';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('AgeSelectコンポーネント', () => {
  test('ドロップダウンの選択が正しく動作すること', () => {
    const handleChange = jest.fn();
    const identifier = 'age';
    const { getByDisplayValue } = render(
      <AgeSelect identifier={identifier} onChange={handleChange} />
    );

    const selectElement = getByDisplayValue('選択してください');
    fireEvent.change(selectElement, { target: { value: '10' } });

    expect(handleChange).toHaveBeenCalledWith(identifier, '10');
  });
});

