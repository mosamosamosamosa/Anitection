import React from 'react';
import Layout from '../templates/Layout';
import Card from '../templates/Card';
import Navigation from '../organisms/Navigation';
import UserPanel from '../organisms/UserPanel';
import { Icon } from '@iconify/react';
import InfoHeader from '../atoms/InfoHeader';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden md:block col-span-12 md:col-span-2">
          <UserPanel />
          <Navigation />
        </div>

        <div className="col-span-12 md:col-span-7 space-y-4">
          {/* タイムライン */}
          {[...Array(24)].map((_, index: number) => (
            <Card key={index}>
              <div className="w-full h-40">contents</div>
            </Card>
          ))}
        </div>

        {/* 情報 */}
        <div className="col-span-12 md:col-span-3 space-y-4 hidden lg:block">
          {/* 施設情報 */}
          <InfoHeader icon="ion:home-outline" title="施設情報" />
          <Card>
            <div className="w-full h-40">contents</div>
            <div className="absolute bottom-2 right-4 flex justify-end items-end">
              <p className="text-sm">詳細へ</p>
              <Icon icon="tdesign:swap-right" className="w-6" />
            </div>
          </Card>
          {/* 動物情報 */}
          <InfoHeader icon="cil:animal" title="動物情報" />
          <Card>
            <div className="w-full h-40">contents</div>
            <div className="absolute bottom-2 right-4 flex justify-center items-center">
              <Icon icon="tdesign:swap-right" className="mt-1 w-6" />
            </div>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
