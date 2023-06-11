import React from 'react';
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    BarElement,
    BarController,
    PointElement,
    LineElement,
    LineController,
    Title,
    Tooltip,
    Legend,
  } from 'chart.js';
import { Bar } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  LineController,
  BarController,
  PointElement
);

const ResultGraph = ({ monthlyAmount, age, costArray }) => {
  //3年ごとの積立累計額を配列savingDatasに渡す
  let savingDatas = [];
  let current = 0;
  let ans = 0;
  for (let i = 0; i < 7; i++) {
    const duration = (i * 3 - age) * 12
    if ( duration < 0 ){
      savingDatas.push(0);
    } else {
      ans = monthlyAmount * duration;
      savingDatas.push(ans);
    }
    current = ans;
  }
  savingDatas.push(current);

  //3年ごとの累計教育費をcostArrayから算出して配列costDatasに渡す
  let costDatas = [0];
  let costData = 0;
  let count = 0;

  for (let i = 0; i < costArray.length; i++) {
    if (i === 2 || i === 3) {
      costData += costArray[2] / 2;
      if ( i === 3 ){ count += 1; }
    } else if (count === 5 && costArray[count + 1] !== 0) {
      costData += costArray[count] + costArray[count + 1];
    } else {
      costData += costArray[count];
      count += 1;
    }
    costDatas.push(costData);
  }

  const options = {
    maintainAspectRatio: false
  }

  const graphData = {
    labels: [
      //軸ラベル
      '0才', '3才', '6才', '9才', '12才', '15才', '18才', '22才'
    ],
    datasets: [
      //表示するデータセット
      {
        type: 'bar',
        data: savingDatas,
        backgroundColor: 'rgba(30, 144, 255, 0.5)',
        label: '積立累計額（円）',
      },
      {
        type: 'line',
        data: costDatas,
        backgroundColor: 'rgba(255, 69, 0, 0.5',
        borderColor: 'rgba(255, 69, 0, 0.5)',
        label: '教育費累計額（円）',
      }
    ],
  };

  return (
    <div className='h-64'>
      <Bar data={graphData} options={options} />
    </div>
  );
}

export default ResultGraph;
