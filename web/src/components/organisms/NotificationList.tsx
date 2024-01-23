import React, { FC } from 'react';
import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import Card from '../templates/Card';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import { Icon } from '@iconify/react';

const Component: FC = () => {
  const { user } = useSelector((state: RootState) => state.user);
  const { data, error } = useSWR<any>(
    `/api/notifications?filters[user][id][$eq]=${user.id}`,
    fetchInstanceWithToken(),
  );

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  const notifications = data.data.data;

  return (
    <>
      {notifications.map((notification: any) => (
        <Card key={notification.id}>
          <div className="w-full h-full py-2">
            {/* post content */}
            <div className="w-full h-full flex flex-col gap-4 px-0 py-2 px-2 md:px-12">
              <p className="text-md font-semibold">
                {notification.attributes.content}
              </p>
            </div>
            {/* post info */}
            <div className="flex justify-end items-center gap-2">
              <Icon
                icon="ant-design:clock-circle-outlined"
                className="w-4 h-4"
              />
              <p className="text-sm text-gray-500">
                {new Date(notification.attributes.createdAt).toLocaleString()}
              </p>
            </div>
          </div>
        </Card>
      ))}
    </>
  );
};

export default Component;
