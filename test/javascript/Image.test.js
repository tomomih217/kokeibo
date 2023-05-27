import React from 'react';
import { render } from '@testing-library/react';
import Image from '../../app/javascript/components/components/Image';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Imageコンポーネント', () => {
  it('正しく描画されていること', () => {
    const width = '10';
    const height = '10';
    const src = '/assets/logo.png';
    const alt = 'Image alt text';

    const { getByAltText } = render(<Image width={width} height={height} src={src} alt={alt} />);
    const imageElement = getByAltText(alt);

    expect(imageElement).toBeInTheDocument();
    expect(imageElement).toHaveAttribute('src', src);
    expect(imageElement).toHaveClass(`w-${width}`);
    expect(imageElement).toHaveClass(`h-${height}`);
  });
});
