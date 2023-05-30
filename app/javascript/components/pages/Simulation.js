import React from 'react';
import Text from '../components/Text';
import Card from '../components/Card';

const Simulation = () => {
  return (
    <div className='m-auto'>
      <div className='text-center'>
        <Text size='3xl' color='amber-dark'>教育費シュミレーション</Text>
      </div>
      <div className='m-auto pt-4'>
        <Card widthSize='1/2' title='お子様の年齢'>
          教えて
        </Card>
      </div>
    </div>
  )
};

export default Simulation;
