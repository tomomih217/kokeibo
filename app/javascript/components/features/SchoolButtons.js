import React from 'react';
import Button from '../components/Button';

const SchoolButtons = ({ identifier, selectedButton, onChange }) => {

  const options = (
    identifier === 'university'
    ? [
      { identifier: 'publicArts', value: 'publicArts', label: '公立文系' },
      { identifier: 'publicScience', value: 'publicScience', label: '公立理系'},
      { identifier: 'privateArts', value: 'privateArts', label: '私立文系'},
      { identifier: 'privateScience', value: 'privateScience', label: '私立理系' },
      { identifier: 'unselected', value: 'unselected', label: '通う予定はない' }
    ]
    : (
      identifier === 'nurserySchool' || identifier === 'kindergarten'
      ? [
          { identifier: 'public', value: 'public', label: '公立' },
          { identifier: 'private', value: 'private', label: '私立'},
          { identifier: 'unselected', value: 'unselected', label: '通う予定はない' }
      ]
      : [
        { identifier: 'public', value: 'public', label: '公立' },
        { identifier: 'private', value: 'private', label: '私立'}
      ]
    )
  );
  

  const handleOptionClick = (value) => {
    onChange(identifier, value)
  };

  return (
    <div className='flex justify-center'>
      {options.map((option, index) => (
        <div className='mx-3' key={index}>
          <Button
            onClick={() => handleOptionClick(option.value)}
            pxSize='3'
            pySize='2'
            color={ selectedButton === option.value ? 'yellow-300' : 'white' }
            fontColor='amber-dark'
            roundType='md'
            style='border border-yellow-300 hover:bg-yellow-300'
          >
            {option.label}
          </Button>
        </div>
      ))}
    </div>
  );
};

export default SchoolButtons;
