import React, { useState } from 'react';
import Text from '../components/Text';
import Card from '../components/Card';
import SchoolSelect from '../components/SchoolSelect';
import AgeSelect from '../components/AgeSelect';

const Simulation = () => {
  //ユーザーの入力値を格納
  const [selectedValues, setSelectedValues] = useState({
    age: ''
  });

  // ドロップダウンの値が変更されたときに実行されるハンドラ関数
  const handleDropdownChange = (identifier, value) => {
    setSelectedValues(prevState => ({
        ...prevState,
        [identifier]: value
    }));
  };

  return (
    <div className='m-auto'>
      <div className='text-center'>
        <Text size='3xl' color='amber-dark'>教育費シュミレーション</Text>
      </div>

      <div className='m-auto'>
        <div className='mt-5'>
          <Card widthSize='1/2' title='STEP1'>
            <div className='py-5 text-center'>
              <Text size='md' color='amber-dark'>お子様のご年齢は？</Text>
              <AgeSelect />
            </div>
          </Card>
        </div>
      </div>
    </div>
  )
};

export default Simulation;
