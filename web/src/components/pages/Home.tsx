import React from 'react';
import Layout from '../templates/Layout';
import Navigation from '../organisms/Navigation';
import AnimalList from '../organisms/AnimalList';
import InstitutionInfo from '../organisms/InstitutionInfo';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-3 lg:col-span-2 lg:block">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4">
          <AnimalList />
        </div>

        {/* 情報 */}
        <div className="hidden md:block col-span-12 md:col-span-4 lg:col-span-3 space-y-4">
          <InstitutionInfo />
        </div>
      </div>
    </Layout>
  );
};

export default Component;
