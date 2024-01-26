import React from 'react';
import Layout from '../templates/Layout';
import Navigation from '../organisms/Navigation';
import AnimalDetail from '../organisms/AnimalDetail';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-3 lg:col-span-2 lg:block">
          <Navigation />
        </div>

        <AnimalDetail />
      </div>
    </Layout>
  );
};

export default Component;
