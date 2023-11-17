import React from 'react';
import Layout from '../templates/Layout';

const Component = () => {
  return (
    <Layout>
      <div className="grid grid-cols-12 gap-4">
        <div className="col-span-12 md:col-span-4">
          <div className="mb-4 flex">
            <div className="flex justify-center items-center gap-2 bg-highlight rounded-xl shadow-md px-4 py-2">
              <div className="w-8 h-8 rounded-full bg-white"></div>
              <h2 className="text-2xl font-bold stroked">施設情報</h2>
            </div>
          </div>
          <div className="mb-4">
            <div className="h-full bg-main rounded-md px-4 py-2 shadow-md border-2 border-stroke">
              <div className="w-full h-40">contents</div>
            </div>
          </div>
        </div>
        <div className="col-span-12 md:col-span-8">
          <div className="mb-4 flex">
            <div className="flex justify-center items-center gap-2 bg-highlight rounded-xl shadow-md px-4 py-2">
              <div className="w-8 h-8 rounded-full bg-white"></div>
              <h2 className="text-2xl font-bold stroked">施設情報</h2>
            </div>
          </div>
          <div className="mb-4">
            <div className="h-full bg-main rounded-md px-4 py-2 shadow-md border-2 border-stroke">
              <div className="w-full h-40">contents</div>
            </div>
          </div>
        </div>
        <div className="col-span-12">
          <div className="mb-4 flex">
            <div className="flex justify-center items-center gap-2 bg-highlight rounded-xl shadow-md px-4 py-2">
              <div className="w-8 h-8 rounded-full bg-white"></div>
              <h2 className="text-2xl font-bold stroked">動物情報</h2>
            </div>
          </div>
          <div className="mb-4 flex items-center gap-4">
            <input
              type="text"
              className="w-1/2 h-12 rounded-md px-4 py-2 shadow-md focus:outline-none"
              placeholder="動物名を入力してください"
            />
            <div className="w-12 h-12 rounded-full bg-white border-4"></div>
          </div>
          <div>cards</div>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
