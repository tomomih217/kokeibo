import React from 'react';
import Text from '../Text';
import Image from '../Image';
import Button from '../Button';

const Top = () => {
  const sentences = [
    "この子が希望する進路を選ばせてあげたい。",
    "将来を諦めないで済むように",
    "この子のために、今できることを。",
  ];

  return (
    <div className='flex justify-center items-center h-full'>
      <div className='w-4/12'>
        <div>
          <Text size='3xl' color='amber-vivid'>わが子のために、今できること</Text>
        </div>
        <ul className='mt-10'>
          {sentences.map((sentence, key) => (
            <li id={key} className='mb-3'>
              <Text size='sm' color='amber-dark'>{sentence}</Text>
            </li>
          ))}
        </ul>
        <div className='mt-16 text-center'>
          <Button pxSize='3' pySize='2' color='amber-vivid' fontColor='white' roundType='lg'>教育費シュミレーション</Button>
        </div>
      </div>
      <div className='w-4/12'>
        <div>
          <Image src='/assets/top_image.png' alt='top_image' width='300' height='200' />
        </div>
      </div>
    </div>
  );
};

export default Top;