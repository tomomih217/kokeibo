import React from 'react';

const Button = ({ pxSize, pySize, color, fontColor, roundType, onClick, children }) => {
  // ボタンのスタイルを動的に生成
  const buttonStyle = `py-${pySize} px-${pxSize} bg-${color} text-${fontColor} rounded-${roundType}`;

  return (
    <button className={buttonStyle} onClick={onClick}>
      {children}
    </button>
  );
};

export default Button;

