import React, { memo, FC, ReactNode } from 'react';

import Header from '../organisms/Header';
import Navigation from '../organisms/Navigation';
import UserPanel from '../organisms/UserPanel';
import Breadcrumbs from '../organisms/Breadcrumbs';

type Props = {
  children: ReactNode;
};

const Component: FC<Props> = ({ children }) => {
  return (
    <div className="App h-screen flex flex-col">
      <Header />
      <div className="flex flex-grow">
        <aside className="bg-main w-1/6 p-4 h-full">
          <div className="sticky top-8">
            <UserPanel />
            <Navigation />
          </div>
        </aside>
        <div className="flex-grow">
          <Breadcrumbs />
          <div className="max-w-5xl mx-auto px-4 py-8">
            <main className="flex-grow">{children}</main>
          </div>
        </div>
      </div>
    </div>
  );
};

export default memo(Component);
