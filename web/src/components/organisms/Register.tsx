import { useState, FC } from 'react';
import { useDispatch } from 'react-redux';
import { viewSlice } from '../../features/view';

import Modal from '../templates/Modal';

const Component: FC = () => {
  const dispatch = useDispatch();
  const [message, setMessage] = useState<string>('');

  const handleCloseClick = () => {
    dispatch(viewSlice.actions.toggleRegisterModal());
  };

  const handleLoginClick = () => {
    setMessage('登録が完了しました');
  };

  return (
    <Modal text='登録' handleClick={handleCloseClick}>
      <div className='flex flex-col justify-center items-center gap-4 mb-12'>
        <div className='flex flex-col justify-center items-start'>
          <p className='text-headline font-bold'>メールアドレス</p>
          <input type='text' className='w-64 h-8 rounded-md border border-gray-300 px-1' />
        </div>
        <div className='flex flex-col justify-center items-start'>
          <p className='text-headline font-bold'>パスワード</p>
          <input type='password' className='w-64 h-8 rounded-md border border-gray-300 px-1' />
        </div>
        <div className='flex flex-col justify-center items-start'>
          <p className='text-headline font-bold'>パスワード確認</p>
          <input type='password' className='w-64 h-8 rounded-md border border-gray-300 px-1' />
        </div>
      </div>
      <div className='flex flex-col justify-center items-center'>
        <button className='w-64 h-8 rounded-md bg-icons-tertiary text-white font-bold' onClick={handleLoginClick}>
          登録
        </button>
        <p className='text-icons-tertiary text-sm mt-10 ml-4'>&nbsp;{message}</p>
      </div>
    </Modal>
  );
};

export default Component;