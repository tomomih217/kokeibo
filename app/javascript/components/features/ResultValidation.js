import React from 'react';

const ResultValidation = ({ resultHash, children }) => {
  const isEmpty = Object.values(resultHash).some(value => value === '' && value !== '0');

  return (
    <div>
      {isEmpty ? <p>入力が完全ではありません</p> : children }
    </div>
  );
};

export default ResultValidation;
