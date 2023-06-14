import React from "react";
import Text from './Text';

const Container = ({ title, children }) => {
  return (
    <div className='mb-24'>
      <div className='mb-5 text-center'>
        <Text size='3xl' color='amber-dark'>{title}</Text>
      </div>

      <div className='m-auto'>
        {children}
      </div>
    </div>
  );
};

export default Container;
