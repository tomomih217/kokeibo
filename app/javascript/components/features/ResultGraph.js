import React from 'react';
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend,
  } from 'chart.js';
import { Bar } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

const ResultGraph = ({ monthlyAmount }) => {
  let datas = [0];
  let current = 0;
  for (let i = 0; i < 6; i++) {
    const ans = current + monthlyAmount * 36;
    datas.push(ans);
    current = ans;
  }

  const graphData = {
    labels: [
      //軸ラベル
      '0才', '3才', '6才', '9才', '12才', '15才', '18才'
    ],
    datasets: [
      //表示するデータセット
      {
        data: datas,
        backgroundColor: 'rgba(30, 144, 255, 0.5)',
        label: '積立累計額（円）',
      },
    ],
  };

  return (
    <div>
      <Bar data={graphData} />
    </div>
  );
}

export default ResultGraph;
