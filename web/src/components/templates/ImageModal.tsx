import React, { FC, ReactNode } from 'react';
import { Icon } from '@iconify/react';
import Card from '../templates/Card';

type Props = {
  children: ReactNode;
  onClick: () => void;
};

const Component: FC<Props> = ({ children, onClick }) => {
  return (
    <div className="fixed inset-0 bg-background bg-opacity-80 flex justify-center items-center z-30">
      <div
        className="absolute inset-0 flex justify-center items-center z-40"
        onClick={onClick}
      >
        <div className="w-full h-full"></div>
      </div>
      <div className="z-50 flex justify-center items-center w-10/12 md:w-8/12 lg:w-6/12">
        <Card>
          <div className="flex justify-between items-start">
            <div className="flex justify-start items-center gap-2 m-2">
              <Icon icon="ant-design:picture-outlined" className="w-6 h-6" />
              <h1 className="text-2xl font-bold">画像</h1>
            </div>
            <button
              className="p-2 text-icons-main rounded-md"
              onClick={onClick}
            >
              <Icon icon="ant-design:close-outlined" className="w-6 h-6" />
            </button>
          </div>
          <div className="py-8 md:py-0 md:py-24 px-0 md:px-12 h-full flex flex-col justify-center items-center">
            {children}
          </div>
        </Card>
      </div>
    </div>
  );
};

export default Component;
