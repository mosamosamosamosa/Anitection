import React from 'react';

const Component = () => {
  return (
    <div className="mb-4 flex gap-4 items-center border-b border-gray-300 pb-4">
      <div className="w-12 h-12 rounded-full bg-blue-500"></div>
      <div className="flex flex-col">
        <p className="text-lg font-semibold mt-2">John Doe</p>
        <p className="text-sm text-gray-500">@johndoe</p>
      </div>
    </div>
  );
};

export default Component;
