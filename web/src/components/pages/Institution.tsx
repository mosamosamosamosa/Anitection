import React from 'react';
import Layout from '../templates/Layout';

import Navigation from '../organisms/Navigation';
import InstitutionDetail from '../organisms/InstitutionDetail';

import InfoHeader from '../atoms/InfoHeader';
import Card from '../templates/Card';
import { Icon } from '@iconify/react';
import { Link } from 'react-router-dom';

const Chat: React.FC = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-3 lg:col-span-2 lg:block">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4">
          <InstitutionDetail />
        </div>

        {/* 情報 */}
        <div className="hidden md:block col-span-12 md:col-span-4 lg:col-span-3 space-y-4">
          {/* ポイント */}
          <InfoHeader icon="bx:bx-coin-stack" title="ポイント" />
          <Card>
            {/* 送金 */}
            <Link to={`/send`}>
              <div className="w-full flex justify-center items-center">
                <ul className="flex flex-col gap-2 py-2 w-full">
                  {/* 現在のポイント */}
                  <li className="flex gap-2 items-center">
                    <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                    <p className="text-sm">保有ポイント：</p>
                    <p>1000</p>
                  </li>
                  {/* いままでの寄付金額 */}
                  <li className="flex gap-2 items-center">
                    <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                    <p className="text-sm">寄付金額：</p>
                    <p>3500</p>
                  </li>
                </ul>
              </div>
              <div className="absolute bottom-2 right-4 flex justify-end items-end">
                <p className="text-sm">送金する</p>
                <Icon icon="tdesign:swap-right" className="w-6" />
              </div>
            </Link>
          </Card>
          <InfoHeader icon="bx:bx-chat" title="チャット" />
          <Card>
            <Link to={`/chat`}>
              <div className="w-full flex justify-center items-center">
                <ul className="flex flex-col gap-2 py-2 w-full">
                  <li className="flex gap-2 items-center justify-around">
                    <div className="flex gap-2 items-center justify-center">
                      <Icon icon="bx:bx-user" className="w-4 h-4 mr-1" />
                      <p>hogeさん</p>
                    </div>
                    <div className="flex gap-2 items-center justify-center">
                      {
                        /* もし新規メッセージがあればびっくりアイコンを表示 */
                        true && (
                          <Icon
                            icon="bx:bx-bell"
                            className="w-4 h-4 mr-1 text-red-500"
                          />
                        )
                      }
                      <Icon icon="bx:bx-chevron-right" className="w-4 h-4" />
                    </div>
                  </li>
                </ul>
              </div>
            </Link>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Chat;
