import React from 'react';

const Button = ({ pxSize, pySize, color, fontColor, roundType, style, onClick, children }) => {
  // ボタンのスタイルを動的に生成
  const buttonStyle = style
    ? `py-${pySize} px-${pxSize} bg-${color} text-${fontColor} rounded-${roundType} ${style}`
    : `py-${pySize} px-${pxSize} bg-${color} text-${fontColor} rounded-${roundType}`;

  return (
    <button className={buttonStyle} onClick={onClick}>
      {children}
    </button>
  );
};

export default Button;

