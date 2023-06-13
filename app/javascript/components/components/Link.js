import React from "react";

const Link = ({ page, children }) => {
  return (
    <a href={page}>
      {children}
    </a>
  );
};

export default Link;
