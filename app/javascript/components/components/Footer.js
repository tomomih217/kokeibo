import React from 'react';
import Text from './Text';
import Link from './Link';

const Footer = () => {
  return (
    <footer className='absolute bottom-0 w-full'>
      <div className='w-4/5 m-auto'>
        <div className='flex justify-around'>
          <Link page='/privacypolicy'>
            <Text size='sm' color='blue-500'>プライバシーポリシー</Text>
          </Link>
          <Text size='sm' color='blue-500'>利用規約</Text>
          <Text size='sm' color='blue-500'>お問い合わせ</Text>
        </div>
        <div className='text-center my-3'>
          <Text size='sm' color='amber-dark'>＠ Tomomi Hashimoto All Rights reserved.</Text>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
