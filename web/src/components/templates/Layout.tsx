import React, { useEffect, memo, FC, ReactNode } from 'react';

import Header from '../organisms/Header';
import Navigation from '../organisms/Navigation';
import UserPanel from '../organisms/UserPanel';
import Breadcrumbs from '../organisms/Breadcrumbs';

import { useSelector } from 'react-redux';
import { RootState } from '../../store';

import { useDispatch } from 'react-redux';
import { viewSlice } from '../../features/view';

import Login from '../organisms/Login';
// import Register from '../organisms/Register';

type Props = {
  children: ReactNode;
};

const Component: FC<Props> = ({ children }) => {
  const dispatch = useDispatch();
  const { mobile, sidebar } = useSelector((state: RootState) => state.view);

  window.addEventListener('resize', () => {
    if (window.innerWidth >= 1024) {
      dispatch(viewSlice.actions.setMobile(false));
      dispatch(viewSlice.actions.setSidebar(true));
    } else {
      dispatch(viewSlice.actions.setMobile(true));
      dispatch(viewSlice.actions.setSidebar(false));
    }
  });

  useEffect(() => {
    if (window.innerWidth <= 1024) {
      dispatch(viewSlice.actions.setMobile(true));
      dispatch(viewSlice.actions.setSidebar(false));
    }
  }, []);

  return (
    <div className="App h-screen flex flex-col">
      <div className="flex flex-grow">
        {mobile && sidebar && (
          <div
            className="fixed w-full top-0 left-0 h-screen z-10 bg-opacity-60 bg-gray-400"
            onClick={() => dispatch(viewSlice.actions.toggleSidebar())}
          >
            <div className="animate-slide-in-left w-3/5 bg-main h-full px-2 overflow-y-auto">
              <div className="sticky top-8">
                <UserPanel />
                <Navigation />
              </div>
            </div>
            <div className="fixed top-0 right-0 w-2/5 h-full" />
          </div>
        )}
        {!mobile && (
          <aside
            className={`bg-main h-full relative border-r border-gray-300 duration-300 transition-all ${
              sidebar ? 'w-1/6 p-4' : 'w-0'
            }`}
          >
            {sidebar && (
              <div className="sticky top-8">
                <UserPanel />
                <Navigation />
              </div>
            )}
          </aside>
        )}
        <div className="flex-grow">
          <Header />
          <Breadcrumbs />
          <div className="max-w-6xl mx-auto px-4 py-8">
            <main className="flex-grow">{children}</main>
          </div>
        </div>
        <Login />
      </div>
    </div>
  );
};

export default memo(Component);
