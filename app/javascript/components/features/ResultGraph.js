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

const ResultGraph = ({ monthlyAmount, costArray }) => {
  let savingDatas = [0];
  let current = 0;
  for (let i = 0; i < 6; i++) {
    const ans = current + monthlyAmount * 36;
    savingDatas.push(ans);
    current = ans;
  }
  savingDatas.push(current);

  let costDatas = [0];
  let costData = 0;
  //3才までの累計コスト
  costData = costArray[0];
  costDatas.push(costData);
  //6才までの累計コスト
  costData = costData + costArray[1]
  costDatas.push(costData);
  //９才までの累計コスト
  costData = costData + costArray[2] / 2
  costDatas.push(costData);
  //12才までの累計コスト
  costData = costData + costArray[2] / 2
  costDatas.push(costData);
  //15才までの累計コスト
  costData = costData + costArray[3]
  costDatas.push(costData);
  //18才までの累計コスト
  costData = costData + costArray[4]
  costDatas.push(costData);
  //22才までの累計コスト
  costData = costData + costArray[5]
  costDatas.push(costData);

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
        label: '教育費（円）',
      }
    ],
  };

  return (
    <div>
      <Bar data={graphData} />
    </div>
  );
}

export default ResultGraph;
