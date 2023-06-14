import React from "react";
import { render, getAllByText } from '@testing-library/react';
import PrivacyPolicy from "../../../app/javascript/components/pages/PrivacyPolicy";

describe('PrivacyPolicyコンポーネント', () => {
  it('プライバシーポリシーが表示されていること', () => {
    const { getAllByText } = render(<PrivacyPolicy />);
    const titleElement = getAllByText('プライバシーポリシー');

    expect(titleElement.length).toBe(1);
  })
})