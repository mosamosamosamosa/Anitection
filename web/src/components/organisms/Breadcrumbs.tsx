import React, { FC } from 'react';
import { Link } from 'react-router-dom';

type Props = {
  path: string;
};

const Component:FC<Props> = ({ path }) => {
  const paths = path.split('/').filter((p) => p);

  return (
    <nav className="p-2">
      <ol className="list-reset flex text-sm">
        <li>
          <Link to="/" className="text-blue-500 hover:underline">
            home
          </Link>
        </li>
        {paths.map((p, index) => {
          return (
            <>
              <li className="mx-2">/</li>
              <li key={index}>
                <Link
                  to={`/${paths.slice(0, index + 1).join('/')}`}
                  className="text-blue-500 hover:underline"
                >
                  {p}
                </Link>
              </li>
            </>
          );
        })}
      </ol>
    </nav>
  );
};

export default Component;
