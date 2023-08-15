import React from 'react';

const LivingAloneFundsSelectDropdown = ({ identifier, onChange }) => {

  const handleDropdownChange = event => {
    const selectedValue = event.target.value;
    onChange(identifier, selectedValue);
  };

  return (
    <div>
      <select id='livingAloneFunds' className='border-2 border-gray-200 rounded-md p-1 hover:border-blue-400' onChange={handleDropdownChange}>
        <option value="">金額を選択してください</option>
        <option value="0">仕送りの予定はない</option>
        {Array.from({ length: 10 }, (_, index) => {
          const amount = (index + 1) * 10000;
          return (
            <option key={amount} value={amount}>
              {index + 1}万円
            </option>
          );
        })}
      </select>
    </div>
  );
};

export default LivingAloneFundsSelectDropdown;
