import { Icon } from '@iconify/react';
import React from 'react';

import { useDispatch } from 'react-redux';
import { viewSlice } from '../../features/view';

const Component = () => {
  const dispatch = useDispatch();

  const handleReload = () => {
    window.location.reload();
  }

  const handleSidebar = () => {
    dispatch(viewSlice.actions.toggleSidebar());
  }

  return (
    <header className="bg-highlight px-4 py-2 flex justify-between items-center">
      <div className="flex gap-2 items-center">
        <button className="w-10 h-10 p-1 hover:cursor-pointer rounded hover:bg-white" onClick={handleSidebar}>
          <Icon icon="ant-design:menu-outlined" className="w-8 h-8" />
        </button>
        <h1 className="py-2 text-2xl font-bold">Anitection</h1>
      </div>
      <div className="flex gap-2 items-center">
        <button className="w-10 h-10 p-1 rounded-full hover:cursor-pointer hover:bg-white">
          <Icon icon="ant-design:question-circle-outlined" className="w-8 h-8" />
        </button>
        <button className="w-10 h-10 p-1 rounded-full hover:cursor-pointer hover:bg-white" onClick={handleReload}>
          <Icon icon="ant-design:reload-outlined" className="w-8 h-8" />
        </button>
      </div>
    </header>
  );
};

export default Component;
