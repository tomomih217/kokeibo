import React from 'react';
import { render } from '@testing-library/react';
import Result from '../../../app/javascript/components/features/Result';
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('Result', () => {
  test('正しい結果が表示されること', () => {
    const selectedValues = {
      age: '10',
      nurserySchool: 'public',
      kindergarten: 'private',
      primarySchool: 'public',
      juniorHighSchool: 'private',
      highSchool: 'public',
      university: 'publicScience',
      livingAloneFunds: ''
    };

    const json = {
      nurserySchool: {
        public: 10000,
        private: 20000
      },
      kindergarten: {
        public: 30000,
        private: 40000
      },
      primarySchool: {
        public: 50000,
        private: 60000
      },
      juniorHighSchool: {
        public: 70000,
        private: 80000
      },
      highSchool: {
        public: 90000,
        private: 100000
      },
      university: {
        publicScience: 110000,
        privateScience: 120000
      }
    };

    const { getByText } = render(<Result {...selectedValues} json={json} />);
    // カスタムのテキストマッチャー関数を使用して要素を検索
    const durationText = getByText((content, element) => {
      return element.tagName.toLowerCase() === 'p' && content.includes('〜18才まで');
      });
  
    const amountText = getByText((content, element) => {
      return element.tagName.toLowerCase() === 'p' && content.includes('総額：');
      });
    const monthlyAmountText = getByText((content, element) => {
      return element.tagName.toLowerCase() === 'p' && content.includes('月額');
    });

    expect(durationText).toBeInTheDocument();
    expect(amountText).toBeInTheDocument();
    expect(monthlyAmountText).toBeInTheDocument();
  });
});
