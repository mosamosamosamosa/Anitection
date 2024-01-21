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
                <ul className="flex flex-col gap-2 py-2">
                  <li className="flex gap-2 items-center">
                    <Icon icon="bx:bx-transfer" className="w-4 h-4 mr-1" />
                    <p>送金</p>
                  </li>
                </ul>
              </div>
            </Link>
          </Card>
          <InfoHeader icon="bx:bx-user" title="ユーザー" />
          <Card>
            <Link to={`/chat`}>
              <div className="w-full flex justify-center items-center">
                <ul className="flex flex-col gap-2 py-2">
                  <li className="flex gap-2 items-center">
                    <Icon icon="bx:bx-message" className="w-4 h-4 mr-1" />
                    <p>hogeさん</p>
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
