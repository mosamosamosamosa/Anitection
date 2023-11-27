import React from 'react';

const Component = () => {
  return (
    <div className="mb-4 flex gap-4 items-center border-b border-gray-300 pb-4">
      <img
        className="w-12 h-12 rounded-full"
        src="https://picsum.photos/300/300"
        alt="user"
      />
      <div className="flex flex-col overflow-hidden whitespace-nowrap">
        <p className="text-lg font-semibold">John Doe</p>
        <p className="text-sm text-gray-500">@johndoe</p>
      </div>
    </div>
  );
};

export default Component;
