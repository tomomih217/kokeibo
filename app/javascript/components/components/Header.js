import React from 'react';
import Logo from './Logo';
import Button from './Button';
import Link from './Link';

const Header = () => {
  return (
    <header className='fixed top-0 left-0 w-full bg-transparent z-50'>
      <div className="flex justify-between items-center px-4 py-2">
        <Link page='/'>
          <Logo />
        </Link>
        <Button pxSize='3' pySize='2' color='green-200' fontColor='amber-dark' roundType='full'>ログイン</Button>
      </div>
    </header>

  );
};

export default Header;
