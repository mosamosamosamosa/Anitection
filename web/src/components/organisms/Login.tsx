import React, { FC, useState } from 'react';
import { useDispatch } from 'react-redux';
import { viewSlice } from '../../features/view';

import Modal from '../templates/Modal';

const Component: FC = () => {
  const [message, setMessage] = useState<string>('');
  const dispatch = useDispatch();

  const handleCloseClick = () => {
    dispatch(viewSlice.actions.toggleLoginModal());
  };

  const handleRegisterClick = () => {
    dispatch(viewSlice.actions.toggleLoginModal());
    dispatch(viewSlice.actions.toggleRegisterModal());
  };

  const handleResetClick = () => {
    setMessage('パスワード再設定用のメールを送信しました');
  };

  return (
    <Modal text='ログイン' handleClick={handleCloseClick}>
      <div className='flex flex-col justify-center items-center gap-4 mb-12'>
        <div className='flex flex-col justify-center items-start'>
          <p className='font-bold'>メールアドレス</p>
          <input type='text' className='w-64 h-8 rounded-md border border-gray-300 px-1 outline-none focus:border-highlight' />
        </div>
        <div className='flex flex-col justify-center items-start'>
          <p className='font-bold'>パスワード</p>
          <input type='password' className='w-64 h-8 rounded-md border border-gray-300 px-1 outline-none focus:border-highlight' />
        </div>
      </div>
      <div className='flex flex-col justify-center items-center'>
        <button className='w-64 h-8 rounded-md bg-highlight text-white font-bold'>ログイン</button>
        <div className='flex flex-col justify-center items-center'>
          <p className='text-sm mt-2' onClick={handleRegisterClick}>
            新規作成はこちら
          </p>
          <p className='text-sm mt-4 ml-4' onClick={handleResetClick}>
            パスワードを忘れた方はこちら
          </p>
          <p className='text-red-500 text-sm mt-10 ml-4'>&nbsp;{message}</p>
        </div>
      </div>
    </Modal>
  );
};

export default Component;