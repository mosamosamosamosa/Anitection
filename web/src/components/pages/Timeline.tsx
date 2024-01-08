import React from 'react';
import Layout from '../templates/Layout';
import Navigation from '../organisms/Navigation';
import InfoHeader from '../atoms/InfoHeader';
import Timeline from '../organisms/Timeline';
import MyTimeline from '../organisms/MyTimeline';
import TimelineForm from '../organisms/TimelineForm';

const Component = () => {
  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden lg:block col-span-12 md:col-span-2">
          <Navigation />
        </div>

        <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4">
          <TimelineForm />
          {/* タイムライン */}
          <Timeline />
        </div>

        <div className="col-span-12 md:col-span-4 lg:col-span-3 space-y-4 hidden md:block">
          {/* 施設投稿一覧 */}
          <InfoHeader icon="ant-design:profile-outlined" title="施設の投稿" />
          {/* タイムライン */}
          <MyTimeline />
        </div>
      </div>
    </Layout>
  );
};

export default Component;
