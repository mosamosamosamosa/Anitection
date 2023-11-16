import React from 'react';
import Layout from '../templates/Layout';

const Component = () => {
  return (
    <Layout>
      <div className="mb-4 flex">
        <div className="flex items-center gap-2 bg-highlight rounded-xl shadow-md px-4 py-2">
          <div className="w-10 h-10 rounded-full bg-blue-500"></div>
          <h2 className="text-2xl font-bold stroked">施設情報</h2>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
