import React from 'react';
import { Pie } from 'react-chartjs-2';
import {Chart, ArcElement, Title, Tooltip, Legend} from 'chart.js';
Chart.register(ArcElement,Title, Tooltip, Legend);

const PieChart = ({ items, amounts }) => {
  const data = {
    labels: items, // 費目の配列
    datasets: [
      {
        data: amounts, // 費目ごとの合計金額の配列
        backgroundColor: [
          'rgba(255, 99, 132, 0.6)',
          'rgba(54, 162, 235, 0.6)',
          'rgba(255, 206, 86, 0.6)',
          'rgba(75, 192, 192, 0.6)',
          // ここに必要なだけ色を追加できます
        ],
      },
    ],
  };

  const options = {
    plugins: {
      legend: {
        display: true,
        position: 'bottom', // 凡例の表示位置（top, left, right, bottomのいずれか）
      },
    },
  };

  return (
    <div>
      <Pie data={data} options={options} />
    </div>
  );
};

export default PieChart;
