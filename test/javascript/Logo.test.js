import React from 'react';
import { render } from '@testing-library/react';
import Logo from '../../app/javascript//components/components/Logo';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Logoコンポーネント', () => {
  it('画像とラベルが正しく表示されること', () => {
    const imageSrc = '/assets/logo.png';
    const altText = 'logo_image'
    const labelText = 'コケーボ';

    const { getByAltText, getByText } = render(<Logo />);

    const imageElement = getByAltText(altText);
    expect(imageElement).toBeInTheDocument();
    expect(imageElement.getAttribute('src')).toBe(imageSrc);

    const labelElement = getByText(labelText);
    expect(labelElement).toBeInTheDocument();
  });
});
