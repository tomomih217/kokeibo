import React from 'react';
import Text from './Text';
import Link from './Link';

const Footer = () => {
  return (
    <footer className='w-full py-5 bg-gray-200'>
      <div className='w-4/5 m-auto'>
        <div className='flex justify-around'>
          <Link page='/privacypolicy'>
            <Text size='sm' color='blue-500'>プライバシーポリシー</Text>
          </Link>
          <Link page='/termandcondition'>
            <Text size='sm' color='blue-500'>利用規約</Text>
          </Link>
        </div>
        <div className='text-center'>
          <Text size='sm' color='amber-dark'>＠ Tomomi Hashimoto All Rights reserved.</Text>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
