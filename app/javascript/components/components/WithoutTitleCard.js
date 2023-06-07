import React from 'react';

const WithoutTitleCard = ({ widthSize, children }) => {
  const cardStyle = `w-${widthSize} rounded-lg border border-amber-dark text-amber-dark bg-amber-card p-4 m-auto`;

  return (
    <div className={cardStyle}>
      <div>{children}</div>
    </div>
    );
};


export default WithoutTitleCard;
