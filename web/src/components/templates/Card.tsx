import React from 'react';

type Props = {
  children: React.ReactNode;
};

const Component = ({ children }: Props) => {
  return (
    <div className="h-full bg-main rounded-md px-4 py-2 shadow-md border-2 border-main hover:shadow-lg relative hover:cursor-pointer hover:border-highlight">
      {children}
    </div>
  );
};

export default Component;
