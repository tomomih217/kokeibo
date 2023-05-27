import React from 'react';
import Text from './Text';

const Footer = () => {
  return (
    <footer>
      <div className='w-4/5 m-auto'>
        <div className='flex justify-around'>
          <Text size='sm' color='blue-500'>プライバシーポリシー</Text>
          <Text size='sm' color='blue-500'>利用規約</Text>
          <Text size='sm' color='blue-500'>お問い合わせ</Text>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
