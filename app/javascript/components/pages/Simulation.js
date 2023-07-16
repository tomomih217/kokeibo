import React, { useState } from 'react';
import Container from '../components/Container';
import Button from '../components/Button';
import ResultValidation from '../features/ResultValidation';
import SimulationForm from '../features/SimulationForm';

const Simulation = () => {
  //ユーザーの入力値を格納
  const [selectedValues, setSelectedValues] = useState({
    age: 0,
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
    <div>
      <Container title='教育費シュミレーション'>
        <SimulationForm selectedValues={selectedValues} handleDropdownChange={handleDropdownChange} schoolTypes={schoolTypes} />

        <div className='text-center mt-5 mb-24'>
          <Button pxSize='3' pySize='2' color='amber-vivid' fontColor='white' roundType='md' onClick={handleClick}>
            シミュレーション結果へ
          </Button>

          <div className='mt-10'>
            { showResult && <ResultValidation selectedValues={selectedValues} /> }
          </div>
        </div>
        
      </Container>
    </div>
  )
};

export default Simulation;
