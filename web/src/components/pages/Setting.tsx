import React from 'react';
import Layout from '../templates/Layout';
import Navigation from '../organisms/Navigation';
import UserPanel from '../organisms/UserPanel';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden md:block col-span-12 md:col-span-2">
          <UserPanel />
          <Navigation />
        </div>

        <div className="col-span-12 md:col-span-2 space-y-4">
          {/* 設定なび */}
          <div className="bg-white rounded-xl shadow-md flex justify-center items-center px-2 py-4">
            <div className="w-full h-40">contents</div>
          </div>
        </div>

        {/* 設定 */}
        <div className="col-span-12 md:col-span-8">
          <div className="bg-white rounded-xl shadow-md flex justify-center items-center px-2 py-4">
            <div className="w-full h-96">contents</div>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
