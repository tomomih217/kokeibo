import React from 'react';

const SchoolSelect = ({ identifier, onChange }) => {
  const handleDropdownChange = event => {
    const selectedValue = event.target.value;
    onChange(identifier, selectedValue);
  };
    
  return (
    <select onChange={handleDropdownChange}>
      <option identifier='none' />
      <option identifier='primarySchool'>小学校</option>
    </select>
  );
};
    

export default SchoolSelect;
