import React from 'react';
import PropTypes from 'prop-types';

const Image = ({ width, height, src, alt }) => {
    return(
        <img src={src} alt={alt} className={`w-${width} h-${height}`} />
    );
};

Image.prototype = {
    width: PropTypes.string.isRequired,
    height: PropTypes.string.isRequired,
    src: PropTypes.string.isRequired,
    alt: PropTypes.string.isRequired,
  };

export default Image;
