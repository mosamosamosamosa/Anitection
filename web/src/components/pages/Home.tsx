import React from 'react';
import Layout from '../templates/Layout';
import Card from '../templates/Card';
import InfoHeader from '../atoms/InfoHeader';
import Navigation from '../organisms/Navigation';

import { Icon } from '@iconify/react';
import { Link } from 'react-router-dom';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden md:block col-span-12 md:col-span-2">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 md:col-span-10 lg:col-span-7 space-y-4">
          <div className="flex items-center gap-4">
            <input
              type="text"
              className="w-3/4 md:w-1/2 h-12 rounded-md px-4 py-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
              placeholder="名前を入力"
            />
            {/* ソート */}
            <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
              <Icon icon="icon-park:sort-one" className="w-8 h-8 p-1" />
            </button>
          </div>
          <div className="grid grid-cols-12 gap-4">
            {[...Array(24)].map((_, index: number) => {
              return index === 0 ? (
                <div key={index} className="col-span-6">
                  <Card>
                    <Link
                      to={'/animal-register'}
                      className="w-full h-40 flex justify-center items-center"
                    >
                      <Icon
                        icon="ant-design:plus-outlined"
                        className="w-12 h-12"
                      />
                    </Link>
                  </Card>
                </div>
              ) : (
                <div key={index} className="col-span-6">
                  <Card>
                    <div className="w-full h-40">contents</div>
                  </Card>
                </div>
              );
            })}
          </div>
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
