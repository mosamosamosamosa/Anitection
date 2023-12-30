import React, { FC } from 'react';
import { Icon } from '@iconify/react';

type Props = {
  icon: string;
  highlight?: boolean;
  onClick: () => void;
};

const Component: FC<Props> = ({ icon, highlight = false, onClick }) => {
  return (
    <button
      onClick={onClick}
      className={`flex justify-center items-center gap-2 rounded-xl shadow-md px-4 py-2
      ${highlight ? 'bg-highlight' : 'bg-gray-300'}
    `}
    >
      <Icon icon={icon} height={24} />
    </button>
  );
};

export default Component;
