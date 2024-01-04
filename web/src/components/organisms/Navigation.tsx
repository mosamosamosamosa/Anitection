import React from 'react';
import LinkButton from '../atoms/LinkButton';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';

const Component = () => {
  const { data, error } = useSWR<any>(
    '/api/users/me',
    fetchInstanceWithToken(),
  );

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  return (
    <nav>
      <div className="mb-4 flex gap-4 items-center border-b border-gray-300 py-4">
        {data.data.icon?.url && (
          <img
            className="w-12 h-12 rounded-full"
            src={`${process.env.REACT_APP_API_URL}${data.data.icon.url}`}
            alt="user"
          />
        )}
        <div className="flex flex-col overflow-hidden whitespace-nowrap">
          <p className="text-lg font-semibold">{data.data.username}</p>
          <p className="text-sm text-gray-500">{data.data.email}</p>
        </div>
      </div>
      <ul>
        <li className="mb-2">
          <LinkButton text="ホーム" icon="ion:home-outline" path="/" />
        </li>
        <li className="mb-2">
          <LinkButton
            text="タイムライン"
            icon="mingcute:time-line"
            path="/timeline"
          />
        </li>
        <li className="mb-2">
          <LinkButton
            text="通知"
            icon="ion:notifications-outline"
            path="/notification"
          />
        </li>
        <li className="mb-2">
          <LinkButton text="設定" icon="ion:settings-outline" path="/setting" />
        </li>
      </ul>
    </nav>
  );
};

export default Component;
