import React from 'react';
import Logo from './Logo';
import Button from './Button';
import Link from './Link';
import Text from './Text';

const Header = () => {
  return (
    <header className='fixed top-0 left-0 w-full bg-transparent z-50'>
      <div className="flex justify-between items-center px-4 py-2">
        <Link page='/'>
          <Logo />
        </Link>
        <div className='flex items-center'>
          <Link page='/users/new'>
            <Text size='md' color='blue-500' style='mr-3 underline'>SignUp</Text>
          </Link>
          <Link page='/login'>
            <Button pxSize='3' pySize='2' color='amber-vivid' fontColor='white' roundType='full'>LogIn</Button>
          </Link>
        </div>
      </div>
    </header>

  );
};

export default Header;
