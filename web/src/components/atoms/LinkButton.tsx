import React, { FC } from 'react';
import { Icon } from '@iconify/react';

type Props = {
  icon: string;
  onClick: () => void;
  text: string;
  bold?: boolean;
};

const Component: FC<Props> = ({ icon, onClick, text, bold }) => (
  <button
    className="flex items-center pr-4 py-4 w-full rounded group hover:bg-highlight hover:bg-opacity-30 justify-start"
    onClick={onClick}
  >
    <div className="px-2 w-10 flex justify-center items-center">
      <Icon icon={icon} height={24} />
    </div>
    <p
      className={`whitespace-nowrap group-hover:text-highlight group-hover:underline ${
        bold && 'font-bold'
      }`}
    >
      {text}
    </p>
  </button>
);

export default Component;
