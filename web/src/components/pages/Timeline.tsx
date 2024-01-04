import React from 'react';
import Layout from '../templates/Layout';
import Card from '../templates/Card';
import Navigation from '../organisms/Navigation';
import { Icon } from '@iconify/react';
import InfoHeader from '../atoms/InfoHeader';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden md:block col-span-12 md:col-span-2">
          <Navigation />
        </div>

        <div className="col-span-12 md:col-span-7 space-y-4">
          {/* テキストエリア */}
          <textarea
            className="w-full h-40 rounded-md px-4 py-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            placeholder="今何してる？"
          ></textarea>

          {/* ボタン */}
          <div className="flex justify-between">
            <div className="flex">
              <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
                <Icon
                  icon="ant-design:picture-outlined"
                  className="w-8 h-8 p-1"
                />
              </button>
              <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
                <Icon
                  icon="ant-design:smile-outlined"
                  className="w-8 h-8 p-1"
                />
              </button>
              <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
                <Icon
                  icon="ant-design:calendar-outlined"
                  className="w-8 h-8 p-1"
                />
              </button>
            </div>
            <button className="bg-highlight text-white rounded-md px-4 py-2 shadow-md hover:cursor-pointer hover:bg-white hover:text-highlight">
              ツイート
            </button>
          </div>

          {/* タイムライン */}
          {[...Array(24)].map((_, index: number) => (
            <Card key={index}>
              <div className="w-full h-40">contents</div>
            </Card>
          ))}
        </div>

        <div className="col-span-12 md:col-span-3 space-y-4">
          {/* 施設投稿一覧 */}
          <InfoHeader icon="ant-design:profile-outlined" title="施設投稿" />
          {/* タイムライン */}
          {[...Array(24)].map((_, index: number) => (
            <Card key={index}>
              <div className="w-full h-40">contents</div>
            </Card>
          ))}
        </div>
      </div>
    </Layout>
  );
};

export default Component;
