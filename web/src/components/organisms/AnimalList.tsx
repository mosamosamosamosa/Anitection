import React from 'react';
import Card from '../templates/Card';
import { Icon } from '@iconify/react';
import { Link } from 'react-router-dom';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';

const Component: React.FC = () => {
  const { data, error } = useSWR<any>('/animals', fetchInstanceWithToken());

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  console.log(data.data);

  return (
    <>
      <div className="flex items-center gap-4">
        <input
          type="text"
          className="w-3/4 md:w-1/2 h-12 rounded-md px-4 py-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
          placeholder="名前を入力"
        />
        {/* ソート */}
        <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
          <Icon icon="icon-park:sort-one" className="w-8 h-8 p-1" />
        </button>
      </div>
      <div className="grid grid-cols-12 gap-4">
        {[...Array(24)].map((_, index: number) => {
          return index === 0 ? (
            <div key={index} className="col-span-6">
              <Card>
                <Link
                  to={'/animal-register'}
                  className="w-full h-40 flex justify-center items-center"
                >
                  <Icon
                    icon="ant-design:plus-outlined"
                    className="w-12 h-12"
                  />
                </Link>
              </Card>
            </div>
          ) : (
            <div key={index} className="col-span-6">
              <Card>
                <div className="w-full h-40">contents</div>
              </Card>
            </div>
          );
        })}
      </div>
    </>
  );
}

export default Component;