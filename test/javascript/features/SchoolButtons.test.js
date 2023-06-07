import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import SchoolButtons from '../../../app/javascript/components/features/SchoolButtons';

describe('SchoolButtons', () => {
  const onChangeMock = jest.fn();

  it('should call onChange with the correct arguments when an option is clicked', () => {
    const identifier = 'university';
    const selectedButton = 'publicArts';
    const { getByText } = render(
      <SchoolButtons
        identifier={identifier}
        selectedButton={selectedButton}
        onChange={onChangeMock}
      />
    );

    const optionButton = getByText('公立文系');
    fireEvent.click(optionButton);

    expect(onChangeMock).toHaveBeenCalledWith(identifier, 'publicArts');
  });
});
