import React from "react";
import { render, getAllByText } from '@testing-library/react';
import TermsAndCondition from "../../../app/javascript/components/pages/TermsAndCondition";
import { toBeInTheDocument } from '@testing-library/jest-dom';

describe('TermAndConditionコンポーネント', () => {
  it('テキストが表示されること', () => {
    const { container } = render(<TermsAndCondition />);

    const titleElements = getAllByText(container, '利用規約');
    expect(titleElements.length).toBe(1);
  });
});
