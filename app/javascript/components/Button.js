import React from 'react';

const Button = ({ label, size, color, fontColor, roundType, onClick }) => {
  // ボタンのスタイルを動的に生成
  const buttonStyle = `py-${size} px-${size} bg-${color} text-${fontColor} rounded-${roundType}`;

  return (
    <button className={buttonStyle} onClick={onClick}>
      {label}
    </button>
  );
};

export default Button;

