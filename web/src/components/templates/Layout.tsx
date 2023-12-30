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
import Register from '../organisms/Register';

type Props = {
  children: ReactNode;
};

const Component: FC<Props> = ({ children }) => {
  const dispatch = useDispatch();
  const { sidebar, loginModal, registerModal } = useSelector(
    (state: RootState) => state.view,
  );

  useEffect(() => {
    if (window.innerWidth <= 1024) {
      dispatch(viewSlice.actions.setMobile(true));
      dispatch(viewSlice.actions.setSidebar(false));
    }
  }, []);

  return (
    <div className="App h-screen flex flex-col">
      <div className="flex flex-grow">
        <aside
          className={`fixed md:static bg-main h-full relative border-r border-gray-300 duration-300 transition-all ${
            sidebar ? 'w-full md:w-1/6 p-4' : 'md:w-0'
          }`}
        >
          {sidebar && (
            <div className="sticky top-8">
              <UserPanel />
              <Navigation />
            </div>
          )}
        </aside>
        <div className="flex-grow">
          <Header />
          <Breadcrumbs />
          <div className="max-w-6xl mx-auto px-4 py-8">
            <main className="flex-grow">{children}</main>
          </div>
        </div>
        {!registerModal && loginModal && <Login />}
        {registerModal && <Register />}
      </div>
    </div>
  );
};

export default memo(Component);
