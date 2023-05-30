import React from 'react';

const WithoutTitleCard = ({ children }) => {
  return (
    <div className="w-4/5 rounded-lg border border-amber-dark text-amber-dark bg-amber-card p-4">
      <div>{children}</div>
    </div>
    );
};


export default WithoutTitleCard;
