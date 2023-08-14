import React from 'react';

const EntryAgeSelect = ({ identifier, onChange }) => {
  const handleDropdownChange = event => {
    const age = event.target.value;
    onChange(identifier, age);
  };

  return (
    <div className='flex items-center justify-center mt-3'>
      <span>入園年：</span>
      <select identifier="entryage" className='border-2 border-gray-200 rounded-md p-1 hover:border-blue-400' onChange={handleDropdownChange}>
        <option value="">選択してください</option>
        {Array.from({ length: 5 }, (_, index) => (
          <option key={index + 1} value={index + 1}>{index + 1}才</option>
        ))}
      </select>
    </div>
  );
};

export default EntryAgeSelect;