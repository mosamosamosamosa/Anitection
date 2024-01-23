import React, { FC } from 'react';
import { Icon } from '@iconify/react';
import { Link } from 'react-router-dom';

type Props = {
  icon: string;
  path: string;
  text: string;
  bold?: boolean;
};

const Component: FC<Props> = ({ icon, path, text, bold }) => (
  <Link
    to={path}
    className="flex items-center pr-4 py-4 w-full rounded group hover:bg-highlight hover:bg-opacity-30 justify-start"
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
  </Link>
);

export default Component;
