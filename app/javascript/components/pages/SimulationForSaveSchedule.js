import React, { useState } from 'react';
import Button from '../components/Button';
import ResultValidation from '../features/ResultValidation';
import SimulationForm from '../features/SimulationForm';
import axios from 'axios';

const SimulationForSaveSchedule = () => {
  //ユーザーの入力値を格納
  const [selectedValues, setSelectedValues] = useState({
    age: 0,
    nurserySchool: "",
    kindergarten: "",
    primarySchool: "",
    juniorHighSchool: "",
    highSchool: "",
    university: "",
    livingAloneFunds: ""
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
  ];

  const handleClick = () => {
    setShowResult(true);
  }

  //RailsにデータをJSONで送信する
  const handleSubmit = ({ selectedValues }) => {
    let body = JSON.stringify({ selectedValues });
    fetch('/simulation', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: body
    })
      .then((response) => { return response.json() })
  }

  return(
    <div>
      <SimulationForm selectedValues={selectedValues} handleDropdownChange={handleDropdownChange} schoolTypes={schoolTypes} />
      <div className='text-center mt-5 mb-24'>
        <Button pxSize='3' pySize='2' color='amber-vivid' fontColor='white' roundType='md' onClick={handleClick}>
          シミュレーション結果へ
        </Button>

        <div className='mt-10'>
          { showResult && <ResultValidation selectedValues={selectedValues} /> }
        </div>
      </div>

      <div>
        <Button pxSize='2' pySize='2' color='green-300' fontColor='white' roundType='pill' onClick={handleSubmit(selectedValues)}>積立計画画面に戻る</Button>
      </div>
    </div>
  )
};

export default SimulationForSaveSchedule;
