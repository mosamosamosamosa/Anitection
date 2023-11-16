import React, { memo } from 'react';

// import Header from '../organisms/Header';

type Props = {
  children: React.ReactNode;
};

const Component: React.FC<Props> = ({ children }) => {
  return (
    <div className="App h-screen flex flex-col">
      <header className="bg-stroke p-2 flex justify-between items-center">
        <h1 className="py-4 text-2xl font-bold">Anitection</h1>
        <div className="flex gap-4">
          <a href="/login">ログイン</a>
          <a href="/signup">新規登録</a>
        </div>
      </header>
      <main className="flex-grow">{children}</main>
    </div>
  );
};

export default memo(Component);
