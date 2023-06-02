import React from 'react';

const SchoolSelect = ({ identifier, onChange }) => {
  const handleDropdownChange = event => {
    const selectedValue = event.target.value;
    onChange(identifier, selectedValue);
  };

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
    
  return (
    <select className='border w-40' onChange={handleDropdownChange}>
      <option identifier='none' value=''>選択してください</option>
      { options.map((option) => {
        return <option identifier={option.identifier} value={option.value}>{option.label}</option>;
      }) }
    </select>
  );
};
    

export default SchoolSelect;
