import React from 'react';
import Result from './Result';

const ResultValidation = ({ selectedValues, schoolTypes }) => {
    // ステートの値をチェックしてメッセージを表示
    const objects = selectedValues;
    schoolTypes.forEach((schoolType) => {
      if (schoolType.age <= selectedValues.age) {
        delete objects[schoolType.type];
      }
    });
    const isEmpty = Object.values(objects).some(value => value === '');

  return (
    <div>
      {isEmpty ? <p>入力が完全ではありません</p> : <Result props={selectedValues} />}
    </div>
  );
};

export default ResultValidation;
