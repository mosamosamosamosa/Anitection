import React from "react";

const Component = () => {
  return (
    <header className="bg-highlight px-4 py-2 flex justify-between items-center">
      <h1 className="py-4 text-2xl font-bold">Anitection</h1>
      <div className="flex gap-4">
        <a href="/login">ログイン</a>
        <a href="/signup">新規登録</a>
      </div>
    </header>
  );
};

export default Component;