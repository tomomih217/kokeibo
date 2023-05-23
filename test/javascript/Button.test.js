import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import Button from '../../app/javascript/components/Button';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Buttonコンポーネント', () => {
  it('正しく描画されていること', () => {
    const size = '2';
    const color = 'green-300';
    const fontColor = 'white';
    const roundType = 'full';

    const onClickMock = jest.fn();
    const label = 'Click me';
    const { getByText } = render(<Button label={label} size={size} color={color} fontColor={fontColor} roundType={roundType} onClick={onClickMock} />);
    
    const buttonElement = getByText(label);
    expect(buttonElement).toBeInTheDocument();
    expect(buttonElement).toHaveClass(`py-${size}`);
    expect(buttonElement).toHaveClass(`px-${size}`);
    expect(buttonElement).toHaveClass(`text-${fontColor}`);
    expect(buttonElement).toHaveClass(`bg-${color}`);
    expect(buttonElement).toHaveClass(`rounded-${roundType}`);
  });

  it('クリックイベントが発火すること', () => {
    const onClickMock = jest.fn();
    const label = 'Click me';
    const { getByText } = render(<Button label={label} onClick={onClickMock} />);
    
    const buttonElement = getByText(label);
    fireEvent.click(buttonElement);

    expect(onClickMock).toHaveBeenCalledTimes(1);
  });
});
