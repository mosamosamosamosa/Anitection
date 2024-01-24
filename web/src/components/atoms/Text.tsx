import React, { FC } from 'react';

type Props = {
  value: string;
  onChange: (event: React.ChangeEvent<HTMLInputElement>) => void;
  placeholder: string;
};

const Component: FC<Props> = ({ value, onChange, placeholder }) => {
  return (
    <input
      type="text"
      className="w-3/4 md:w-1/2 h-12 rounded-md px-2 py-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
      placeholder={placeholder}
      value={value}
      onChange={onChange}
    />
  );
};

export default Component;
