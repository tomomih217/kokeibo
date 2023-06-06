import React from 'react';
import Result from './Result';

const ResultValidation = ({ selectedValues }) => {
    // ステートの値をチェックしてメッセージを表示
    const isEmpty = Object.values(selectedValues).some(value => value === '');

  return (
    <div>
      {isEmpty ? <p>入力が完全ではありません</p> : <Result {...selectedValues} />}
    </div>
  );
};

export default ResultValidation;
