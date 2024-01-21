import React from 'react';
import { Routes, Route } from 'react-router-dom';

import { SWRConfig } from 'swr';
import { fetchInstance } from './utils/fetchInstance';

import Home from './components/pages/Home';
import AnimalRegister from './components/pages/AnimalRegister';
import Timeline from './components/pages/Timeline';
import Notfound from './components/pages/Notfound';
import Notifcation from './components/pages/Notification';
import Setting from './components/pages/Setting';
import AnimalDetail from './components/pages/AnimalDetail';
import Institution from './components/pages/Institution';
import Chat from './components/pages/Chat';
import Send from './components/pages/Send';

const App = () => {
  return (
    <SWRConfig
      value={{
        fetcher: (resource, init) =>
          fetchInstance()
            .get(resource, init)
            .then((res) => res.data),
      }}
    >
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/register" element={<AnimalRegister />} />
        <Route path="/register/:id" element={<AnimalRegister />} />
        <Route path="/:id" element={<AnimalDetail />} />
        <Route path="/timeline" element={<Timeline />} />
        <Route path="/notification" element={<Notifcation />} />
        <Route path="/setting" element={<Setting />} />
        <Route path="/institution" element={<Institution />} />
        <Route path="/chat" element={<Chat />} />
        <Route path="/send" element={<Send />} />
        <Route path="/*" element={<Notfound />} />
      </Routes>
    </SWRConfig>
  );
};

export default App;
