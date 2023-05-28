import React from 'react';
import PropTypes from 'prop-types';

const Label = ({ size, color, children }) => {
  const labelStyle = `text-${size} text-${color} `;

  return <span className={labelStyle}>{children}</span>;
};

Label.prototype = {
  size: PropTypes.string.isRequired,
  color: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired,
};

export default Label;
