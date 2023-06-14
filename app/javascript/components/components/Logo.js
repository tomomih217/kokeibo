import React from 'react';
import Image from './Image';
import Label from './Label';

const Logo = () => {
  return(
    <div className='flex flex-row items-center' data-testid='logo'>
      <Image width='10' height='10' src='/assets/logo.png' alt='logo_image' />
      <Label size='lg' color='amber-dark'>コケーボ</Label>
    </div>
  );
};

export default Logo;
