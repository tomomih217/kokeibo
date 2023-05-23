import React from 'react';

const Image = ({ width, height, src, alt }) => {
    return(
        <img src={src} alt={alt} className={`w-${width} h-${height}`} />
    );
};

export default Image;
