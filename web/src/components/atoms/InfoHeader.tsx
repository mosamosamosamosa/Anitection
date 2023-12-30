import React, { FC } from 'react';
import { Icon } from '@iconify/react';

type Props = {
  icon: string;
  title: string;
};

const Component: FC<Props> = ({ icon, title }) => {
  return (
    <div className="flex justify-center items-center gap-2 bg-highlight rounded-xl shadow-md px-4 py-2">
      <Icon icon={icon} height={24} />
      <h2 className="text-2xl stroked font-semibold">{title}</h2>
    </div>
  );
};

export default Component;
