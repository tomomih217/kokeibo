import React from 'react';
import PropTypes from 'prop-types';

const Button = ({ height, width, color, roundness, link, children }) => {
  const buttonStyle = `h-${height} w-${width} bg-${color} rounded-${roundness}`;

  if (link) {
    return (
      <a href={link} className={buttonStyle}>
        {children}
      </a>
    );
  } else {
    return (
      <button className={buttonStyle}>
        {children}
      </button>
    );
  }
};

Button.propTypes = {
  height: PropTypes.string.isRequired,
  width: PropTypes.string.isRequired,
  color: PropTypes.string.isRequired,
  roundness: PropTypes.oneOf(['full', 'md']).isRequired,
  link: PropTypes.string,
  children: PropTypes.node.isRequired,
};

export default Button;
