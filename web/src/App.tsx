import React from 'react';
import { Routes, Route } from 'react-router-dom';

import { SWRConfig } from 'swr';
import { fetchInstance } from './utils/fetchInstance';

import Home from './components/pages/Home';

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
      </Routes>
    </SWRConfig>
  );
};

export default App;
