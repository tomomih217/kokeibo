import React from 'react';
import Button from './Button';

const SchoolButton = (key, onClick, children) => {
  return (
    <Button 
    key={key}
    onClick={onClick}
    pxSize='3'
    pySize='2'
    color='yellow-300'
    fontColor='amber-dark'
    roundType='md'
    style='w-8 h-4'>
      {children}
    </Button>
  )
};

export default SchoolButton;
