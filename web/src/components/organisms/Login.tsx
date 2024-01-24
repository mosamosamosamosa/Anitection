import React, { FC, useState, ChangeEvent } from 'react';
import { useDispatch } from 'react-redux';

import { viewSlice } from '../../features/view';
import { fetchInstance } from '../../utils/fetchInstance';

import Modal from '../templates/Modal';

const Component: FC = () => {
  const dispatch = useDispatch();
  const [message, setMessage] = useState<string>('');
  const [identifier, setIdentifier] = useState<string>('');
  const [password, setPassword] = useState<string>('');

  const handleClick = () => {
    dispatch(viewSlice.actions.setLoginModal(false));
    dispatch(viewSlice.actions.setRegisterModal(false));
  };

  const handleIdentifierChange = (event: ChangeEvent<HTMLInputElement>) => {
    setIdentifier(event.target.value);
  };

  const handlePasswordChange = (event: ChangeEvent<HTMLInputElement>) => {
    setPassword(event.target.value);
  };

  const handleRegisterClick = () => {
    dispatch(viewSlice.actions.setLoginModal(false));
    dispatch(viewSlice.actions.setRegisterModal(true));
  };

  const handleLoginClick = () => {
    if (identifier === '') {
      setMessage('メールアドレスを入力してください');
      return;
    }
    if (password === '') {
      setMessage('パスワードを入力してください');
      return;
    }

    fetchInstance()
      .post('/api/auth/local', {
        identifier: identifier,
        password: password,
      })
      .then((res) => {
        if (res.status === 200) {
          localStorage.setItem('token', res.data.jwt);
          dispatch(viewSlice.actions.setLoginModal(false));
        }
      })
      .catch(() => {
        setMessage('ログインに失敗しました');
      });
  };

  const handleResetClick = () => {};

  return (
    <Modal text="ログイン" onClick={handleClick}>
      <div className="flex flex-col justify-center items-center gap-4 mb-12">
        <div className="flex flex-col justify-center items-start">
          <p className="font-bold">メールアドレス</p>
          <input
            type="text"
            className="w-64 h-8 rounded-md border border-gray-300 px-1 outline-none focus:border-highlight"
            value={identifier}
            onChange={handleIdentifierChange}
          />
        </div>
        <div className="flex flex-col justify-center items-start">
          <p className="font-bold">パスワード</p>
          <input
            type="password"
            className="w-64 h-8 rounded-md border border-gray-300 px-1 outline-none focus:border-highlight"
            value={password}
            onChange={handlePasswordChange}
          />
        </div>
      </div>
      <div className="flex flex-col justify-center items-center">
        <button
          className="w-64 h-8 rounded-md bg-highlight text-white font-bold"
          onClick={handleLoginClick}
        >
          ログイン
        </button>
        <div className="flex flex-col justify-center items-center">
          <p className="text-sm mt-2" onClick={handleRegisterClick}>
            新規作成はこちら
          </p>
          <p className="text-sm mt-4 ml-4" onClick={handleResetClick}>
            パスワードを忘れた方はこちら
          </p>
          <p className="text-red-500 text-sm mt-10 ml-4">&nbsp;{message}</p>
        </div>
      </div>
    </Modal>
  );
};

export default Component;
