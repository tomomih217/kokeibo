import React from "react";
import Text from './Text';

const Container = ({ title, children }) => {
  return (
    <div className='m-auto'>
      <div className='text-center'>
        <Text size='3xl' color='amber-dark'>{title}</Text>
      </div>

      <div className='m-auto'>
        {children}
      </div>
    </div>
  );
};

export default Container;
