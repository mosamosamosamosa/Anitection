import React from 'react';

type Props = {
  children: React.ReactNode;
};

const Component = ({ children }: Props) => {
  return (
    <div className="w-full rounded-md px-4 py-2 shadow-md border-2 border-neutral-100 hover:shadow-lg relative hover:border-highlight bg-neutral-100">
      {children}
    </div>
  );
};

export default Component;
