import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import Button from '../../../app/javascript/components/components/Button';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Buttonコンポーネント', () => {
  test('ボタンが表示されること', () => {
    const { getByText } = render(<Button>Click me</Button>);
    const buttonElement = getByText('Click me');
    expect(buttonElement).toBeInTheDocument();
  });

  test('クリックイベントが正しく動作すること', () => {
    const onClickMock = jest.fn();
    const { getByText } = render(<Button onClick={onClickMock}>Click me</Button>);
    const buttonElement = getByText('Click me');
    fireEvent.click(buttonElement);
    expect(onClickMock).toHaveBeenCalled();
  });

  test('スタイルが正しく適用されること', () => {
    const { getByText } = render(
      <Button pxSize="4" pySize="2" color="blue" fontColor="white" roundType="md">
        Click me
      </Button>
    );
    const buttonElement = getByText('Click me');
    expect(buttonElement).toHaveClass('py-2');
    expect(buttonElement).toHaveClass('px-4');
    expect(buttonElement).toHaveClass('bg-blue');
    expect(buttonElement).toHaveClass('text-white');
    expect(buttonElement).toHaveClass('rounded-md');
  });
});
