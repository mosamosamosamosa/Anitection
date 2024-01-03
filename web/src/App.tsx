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
        <Route path="/animal-register" element={<AnimalRegister />} />
        <Route path="/timeline" element={<Timeline />} />
        <Route path="/notification" element={<Notifcation />} />
        <Route path="/setting" element={<Setting />} />
        <Route path="/*" element={<Notfound />} />
      </Routes>
    </SWRConfig>
  );
};

export default App;
