import React from 'react';
import PropTypes from 'prop-types';

const Text = ({ size, color, style, children }) => {
  const textStyle = style ? `text-${size} text-${color} ${style}` : `text-${size} text-${color}`;

  return <p className={textStyle}>{children}</p>;
};

Text.propTypes = {
  size: PropTypes.string.isRequired,
  color: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired,
};

export default Text;

