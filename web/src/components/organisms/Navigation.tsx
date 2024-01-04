import React from 'react';
import LinkButton from '../atoms/LinkButton';

const Component = () => {
  return (
    <nav>
      <div className="mb-4 flex gap-4 items-center border-b border-gray-300 py-4">
        <div className="flex flex-col overflow-hidden whitespace-nowrap">
          <p className="text-lg font-semibold">John Doe</p>
          <p className="text-sm text-gray-500">@johndoe</p>
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
