import React from 'react';
import Layout from '../templates/Layout';
import Navigation from '../organisms/Navigation';
import Card from '../templates/Card';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-2 lg:block">
          <Navigation />
        </div>

        <div className="col-span-12 md:col-span-3 lg:col-span-2 space-y-4">
          {/* 設定なび */}
          <Card>
            <ul className="flex flex-col gap-2 py-2 w-full space-y-2">
              <li className="flex gap-2">
                <p className="text-sm">プロフィール</p>
              </li>
              <li className="flex gap-2">
                <p className="text-sm">通知</p>
              </li>
              <li className="flex gap-2">
                <p className="text-sm">ログアウト</p>
              </li>
            </ul>
          </Card>
        </div>

        {/* 設定 */}
        <div className="col-span-12 md:col-span-9 lg:col-span-8">
          <Card>
            <div className="w-full flex p-4">
              <ul className="flex flex-col gap-2 py-2 space-y-2">
                <li className="flex gap-2">
                  <input
                    type="text"
                    className="w-full border-2 border-gray-300 rounded-md p-2"
                    placeholder="名前"
                  />
                </li>
                <li className="flex gap-2">
                  <input
                    type="text"
                    className="w-full border-2 border-gray-300 rounded-md p-2"
                    placeholder="メールアドレス"
                  />
                </li>
                <li className="flex gap-2">
                  <input
                    type="text"
                    className="w-full border-2 border-gray-300 rounded-md p-2"
                    placeholder="パスワード"
                  />
                </li>
              </ul>
            </div>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
