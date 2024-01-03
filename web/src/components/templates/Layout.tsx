import React, { useEffect, memo, FC, ReactNode } from 'react';

import Header from '../organisms/Header';
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
    <div className="App h-screen flex-grow">
      <Header sidebar={sidebar} />
      <Breadcrumbs path={window.location.pathname} />
      <main className="flex-grow">{children}</main>
      {!registerModal && loginModal && <Login />}
      {registerModal && <Register />}
    </div>
  );
};

export default memo(Component);
