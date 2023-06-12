import React from 'react';

const WithoutTitleCard = ({ widthSize, bgColor, borderColor, children }) => {
  const cardStyle = `w-${widthSize} rounded-lg border border-${borderColor} text-amber-dark bg-${bgColor} p-4 m-auto`;

  return (
    <div className={cardStyle}>
      <div>{children}</div>
    </div>
    );
};


export default WithoutTitleCard;
