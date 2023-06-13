import React from "react";
import { render, fireEvent } from "@testing-library/react";
import { MemoryRouter } from "react-router-dom";
import Link from "../../../app/javascript/components/components/Link";
import { toBeInTheDocument } from '@testing-library/jest-dom';

test("リンクが正しくレンダリングされること", () => {
  const page = "/example";
  const linkText = "Click me";
  const { getByText } = render(<Link page={page}>{linkText}</Link>);

  const linkElement = getByText(linkText);

  expect(linkElement).toBeInTheDocument();
  expect(linkElement.getAttribute("href")).toBe(page);
});

test("リンクをクリックすると正しいページに遷移すること", () => {
  function Example() {
    return <p>テストだよ</p>;
  }
  
  const page = "/example";
  const linkText = "Click me";
  const { getByText, container } = render(
    <MemoryRouter>
      <Link page={page}>{linkText}</Link>
      <Example path={page} />
    </MemoryRouter>
  );
  
  const linkElement = getByText(linkText);
  
  fireEvent.click(linkElement);
  
  // ページ遷移後のコンポーネントの表示を検証する
  const exampleComponent = container.querySelector("p");
  expect(exampleComponent).toBeInTheDocument();
});
