import React from 'react';
import { render } from '@testing-library/react';
import ResultGraph from '../../../app/javascript/components/features/ResultGraph';
import { toBeInTheDocument } from '@testing-library/jest-dom';
import 'canvas';

beforeAll(() => {
  global.ResizeObserver = jest.fn(function () {
    return {
      observe: jest.fn(),
      unobserve: jest.fn(),
      disconnect: jest.fn(),
    };
  });
});

describe('ResultGraph', () => {
  test('renders graph correctly', () => {
    const monthlyAmount = 1000;
    const age = 25;
    const costArray = [100, 200, 300, 400, 500, 600, 700];

    // コンポーネントをレンダリング
    const { getByTestId } = render(<ResultGraph monthlyAmount={monthlyAmount} age={age} costArray={costArray} />);
    
    // 積立累計額のバーが表示されているかを検証
    const savingGraph = getByTestId('savingGraph');
    expect(savingGraph).toBeInTheDocument();
  });
});

