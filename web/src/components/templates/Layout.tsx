import React, { memo, FC, ReactNode, useEffect } from 'react';

import Header from '../organisms/Header';
import Breadcrumbs from '../molecules/Breadcrumbs';

import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../../store';
import { userSlice } from '../../features/user';
import { institutionSlice } from '../../features/institution';

import Login from '../organisms/Login';
import Register from '../organisms/Register';

import { fetchInstanceWithToken } from '../../utils/fetchInstance';

type Props = {
  children: ReactNode;
};

const Component: FC<Props> = ({ children }) => {
  const dispatch = useDispatch();
  const isLogin = localStorage.getItem('token') ? true : false;
  const { loginModal, registerModal } = useSelector(
    (state: RootState) => state.view,
  );
  const { institution } = useSelector((state: RootState) => state.institution);
  const { user } = useSelector((state: RootState) => state.user);

  useEffect(() => {
    if (!isLogin) return;
    fetchInstanceWithToken()
      .get('/api/users/me')
      .then((res) => {
        if (res.status === 200) {
          const user = res.data;
          dispatch(userSlice.actions.setUser(user));

          fetchInstanceWithToken()
            .get(`/api/employees?filters[users][id][$eq]=${user.id}`)
            .then((res) => {
              if (res.status === 200) {
                const institution =
                  res.data.data[0].attributes.institution.data;
                dispatch(institutionSlice.actions.setInstitution(institution));
              }
            });
        }
      });
  }, [isLogin]);

  return (
    <div className="App h-screen flex-grow">
      <Header />
      <Breadcrumbs path={window.location.pathname} />
      {user && institution && <main className="flex-grow">{children}</main>}
      {!registerModal && loginModal && <Login />}
      {registerModal && <Register />}
    </div>
  );
};

export default memo(Component);
