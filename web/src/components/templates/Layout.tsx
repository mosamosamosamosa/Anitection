import React, { memo, FC, ReactNode } from 'react';

import Header from '../organisms/Header';
import Navigation from '../organisms/Navigation';
import UserPanel from '../organisms/UserPanel';
import Breadcrumbs from '../organisms/Breadcrumbs';

import { useSelector } from 'react-redux';
import { RootState } from '../../store';

type Props = {
  children: ReactNode;
};

const Component: FC<Props> = ({ children }) => {
  const { sidebar } = useSelector((state: RootState) => state.view);
  console.log(sidebar);

  return (
    <div className="App h-screen flex flex-col">
      <div className="flex flex-grow">
        <aside
          className={`bg-main h-full relative border-r border-gray-300 duration-300 transition-all ${
            !sidebar ? 'w-1/6 p-4' : 'w-0'
          }`}
        >
          {!sidebar && (
            <div className="sticky top-8">
              <UserPanel />
              <Navigation />
            </div>
          )}
        </aside>
        <div className="flex-grow">
          <Header />
          <Breadcrumbs />
          <div className="max-w-6xl mx-auto px-4 py-8">
            <main className="flex-grow">{children}</main>
          </div>
        </div>
      </div>
    </div>
  );
};

export default memo(Component);
