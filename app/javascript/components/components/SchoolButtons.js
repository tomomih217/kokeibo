import React, { useState } from 'react';
import Button from './Button';

const SchoolButtons = ({ identifier, onChange }) => {

  const options = (
    identifier === 'university'
    ? [
      { identifier: 'publicArts', value: 'publicArts', label: '公立文系' },
      { identifier: 'publicScience', value: 'publicScrience', label: '公立理系'},
      { identifier: 'privateArts', value: 'privateArts', label: '私立文系'},
      { identifier: 'privateScience', value: 'privateScience', label: '私立理系' }
    ]
    : [
      { identifier: 'public', value: 'public', label: '公立' },
      { identifier: 'private', value: 'private', label: '私立'}
    ]
  );

  const handleOptionClick = (value) => {
    onChange(identifier, value)
  };

  return (
    <div className='flex'>
      {options.map((option) => (
        <Button
          key={option.identifier}
          onClick={() => handleOptionClick(option.value)}
          pxSize='3'
          pySize='2'
          color='yellow-300'
          fontColor='amber-dark'
          roundType='md'
        >
          {option.label}
        </Button>
      ))}
    </div>
  );
};

export default SchoolButtons;
