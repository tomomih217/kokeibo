import React from 'react';

const AgeSelect = ({ identifier, onChange }) => {
  const handleDropdownChange = event => {
    const age = event.target.value;
    onChange(identifier, age);
  };

  return (
    <div>
      <select identifier="age" className='border-2 border-gray-200 rounded-md p-1 hover:border-blue-400' onChange={handleDropdownChange}>
        <option value="">選択してください</option>
        {Array.from({ length: 19 }, (_, index) => (
          <option key={index} value={index}>{index}才</option>
        ))}
      </select>
    </div>
  );
};

export default AgeSelect;
