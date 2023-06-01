import React from 'react';

const AgeSelect = ({ identifier, onChange }) => {
  const handleDropdownChange = event => {
    const selectedValue = event.target.value;
    onChange(identifier, selectedValue);
  };

  return (
    <div>
      <select id="age" className='border' onChange={handleDropdownChange}>
        <option value="">選択してください</option>
        {Array.from({ length: 19 }, (_, index) => (
          <option key={index} value={index}>{index}才</option>
        ))}
      </select>
    </div>
  );
};

export default AgeSelect;
