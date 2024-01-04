import { Icon } from '@iconify/react';
import React, { FC } from 'react';

import Navigation from '../organisms/Navigation';

import { useDispatch } from 'react-redux';
import { viewSlice } from '../../features/view';

type Props = {
  sidebar: boolean;
};

const Component: FC<Props> = ({ sidebar }) => {
  const dispatch = useDispatch();

  const handleReload = () => {
    window.location.reload();
  };

  const handleSidebar = () => {
    dispatch(viewSlice.actions.setSidebar(!sidebar));
  };

  return (
    <header className="shadow bg-highlight px-2 md:px-4 py-1 flex justify-between items-center">
      <div className="flex gap-2 items-center">
        <button
          className="block lg:hidden w-10 h-10 p-1 hover:cursor-pointer rounded hover:bg-white"
          onClick={handleSidebar}
        >
          <Icon icon="ant-design:menu-outlined" className="w-8 h-8" />
        </button>
        <h1 className="py-2 text-2xl font-bold">Anitection</h1>
      </div>
      <div className="flex gap-2 items-center">
        <button className="w-10 h-10 p-1 rounded-full hover:cursor-pointer hover:bg-white">
          <Icon
            icon="ant-design:question-circle-outlined"
            className="w-8 h-8"
          />
        </button>
        <button
          className="w-10 h-10 p-1 rounded-full hover:cursor-pointer hover:bg-white"
          onClick={handleReload}
        >
          <Icon icon="ant-design:reload-outlined" className="w-8 h-8" />
        </button>
      </div>

      {sidebar && (
        <div
          className="fixed w-full top-0 left-0 h-screen z-10 bg-opacity-90"
          onClick={() => dispatch(viewSlice.actions.setSidebar(false))}
        >
          <div className="animate-slide-in-left w-3/5 bg-white h-full px-2 overflow-y-auto">
            <Navigation />
          </div>
          <div className="fixed top-0 right-0 w-2/5 h-full" />
        </div>
      )}
    </header>
  );
};

export default Component;
