import React, { useState } from 'react';
import Text from '../components/Text';
import Card from '../components/Card';
import SchoolSelect from '../features/SchoolSelect';
import AgeSelect from '../components/AgeSelect';
import Label from '../components/Label';
import SchoolButtons from '../components/SchoolButtons';

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

  const schoolTypes = [
    { type: 'nurcerySchool', label: '保育園' }, 
    { type: 'kindergarten', label: '幼稚園' },
    { type: 'primarySchool', label: '小学校' },
    { type: 'juniorHighSchool', label: '中学校' },
    { type: 'highSchool', label: '高等学校' },
    { type: 'university', label: '大学' }
  ]

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

        <div className='mt-10'>
          <Card widthSize='1/2' title='STEP2'>
            <div className='py-5 text-center'>
              <Text size='md' color='amber-dark'>希望進路を選択してください。</Text>
              <div className='lg:px-28 pt-8'>
                { schoolTypes.map((schoolType, index) => {
                  return (
                    <div className='flex justify-between mb-5'>
                      <Label size='md' color='amber-dark'>{schoolType.label}</Label>
                      <SchoolSelect identifier={schoolType.type} onChange={handleDropdownChange} />
                    </div>
                  )
                }) }
              </div>
            </div>
          </Card>
        </div>

        <div className='mt-10'>
          <Card widthSize='1/2' title='STEP3'>
            <div className='py-5 text-center'>
              <Text size='md' color='amber-dark'>仕送り（自宅外通学）予定金額</Text>
            </div>
          </Card>
        </div>

      </div>
    </div>
  )
};

export default Simulation;
