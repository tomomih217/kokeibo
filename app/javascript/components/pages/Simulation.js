import React, { useState } from 'react';
import Text from '../components/Text';
import Card from '../components/Card';
import AgeSelect from '../components/AgeSelect';
import Label from '../components/Label';
import SchoolButtons from '../features/SchoolButtons';
import LivingAloneFundsSelectDropdown from '../features/LivingAloneFundsSelect';
import Button from '../components/Button';
import Result from '../features/Result';
import ResultValidation from '../features/ResultValidation';

const Simulation = () => {
  //ユーザーの入力値を格納
  const [selectedValues, setSelectedValues] = useState({
    age: '',
    nurserySchool: '',
    kindergarten: '',
    primarySchool: '',
    juniorHighSchool: '',
    highSchool: '',
    university: '',
    livingAloneFunds: ''
  });
  const [showResult, setShowResult] = useState(false);

  // ドロップダウンの値が変更されたときに実行されるハンドラ関数
  const handleDropdownChange = (identifier, value) => {
    setSelectedValues(prevState => ({
        ...prevState,
        [identifier]: value
    }));
  };

  const schoolTypes = [
    { type: 'nurserySchool', label: '保育園' }, 
    { type: 'kindergarten', label: '幼稚園' },
    { type: 'primarySchool', label: '小学校' },
    { type: 'juniorHighSchool', label: '中学校' },
    { type: 'highSchool', label: '高等学校' },
    { type: 'university', label: '大学' }
  ]

  const handleClick = () => {
    setShowResult(true);
  }

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
              <AgeSelect identifier='age' selectedAge={selectedValues['age']} onChange={handleDropdownChange} />
            </div>
          </Card>
        </div>

        <div className='mt-10'>
          <Card widthSize='1/2' title='STEP2'>
            <div className='py-5 text-center'>
              <Text size='md' color='amber-dark'>希望進路を選択してください。</Text>
              <div className='lg:px-28 pt-8'>
                { schoolTypes.map((schoolType, index) => {
                  const selectedValue = schoolType.type;
                  return (
                    <div className='flex justify-between mb-5'>
                      <Label size='md' color='amber-dark'>{schoolType.label}</Label>
                      <SchoolButtons identifier={schoolType.type} selectedButton={selectedValues[selectedValue]} onChange={handleDropdownChange} />
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
              <LivingAloneFundsSelectDropdown identifier='livingAloneFunds' onChange={handleDropdownChange} />
            </div>
          </Card>
        </div>

        <div className='text-center mt-5 mb-24'>
          <Button pxSize='3' pySize='2' color='amber-vivid' fontColor='white' roundType='md' onClick={handleClick}>
            シミュレーション結果へ
          </Button>

          <div className='mt-10'>
            { showResult && <ResultValidation selectedValues={selectedValues} /> }
          </div>
        </div>
        
      </div>
    </div>
  )
};

export default Simulation;
