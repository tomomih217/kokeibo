import React from 'react';

const Card = ({ title, children }) => {
  return (
    <div className="w-4/5 rounded-lg border border-amber-dark text-amber-dark bg-amber-card pt-2">
      <h2 className="text-xl text-center mb-2">{title}</h2>
      <div className="bg-white rounded-b-lg px-4">{children}</div>
    </div>
  );
};

export default Card;
