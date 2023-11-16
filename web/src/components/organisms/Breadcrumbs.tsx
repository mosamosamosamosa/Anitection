import React from 'react';

const Component = () => {
  return (
    <nav className="p-2">
      <ol className="list-reset flex text-sm">
        <li>
          <a href="/dashboard" className="text-blue-500 hover:underline">
            Dashboard
          </a>
        </li>
        <li className="mx-2">/</li>
        <li>
          <a href="/profile" className="text-blue-500 hover:underline">
            Profile
          </a>
        </li>
      </ol>
    </nav>
  );
};

export default Component;
