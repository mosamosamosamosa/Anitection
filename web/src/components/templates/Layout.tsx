import React, { memo } from 'react';

// import Header from '../organisms/Header';

type Props = {
  children: React.ReactNode;
};

const Component: React.FC<Props> = ({ children }) => {
  return (
    <div className="App h-screen flex flex-col">
      <header>sdsadf</header>
      <main className="flex-grow">{children}</main>
    </div>
  );
};

export default memo(Component);
