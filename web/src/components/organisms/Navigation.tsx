import React from "react";

const Component = () => {
  return (
    <nav>
      <ul>
        <li className="mb-2">
          <a href="/dashboard" className="text-blue-500 hover:underline">
            Dashboard
          </a>
        </li>
        <li className="mb-2">
          <a href="/profile" className="text-blue-500 hover:underline">
            Profile
          </a>
        </li>
        {/* 他のナビゲーション項目を追加 */}
      </ul>
    </nav>
  );
};

export default Component;