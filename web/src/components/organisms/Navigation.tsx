import React from 'react';
import LinkButton from '../atoms/LinkButton';

const Component = () => {
  return (
    <nav>
      <ul>
        <li className="mb-2">
          <LinkButton
            text="ホーム"
            icon="ion:home-outline"
            onClick={() => {}}
          />
        </li>
        <li className="mb-2">
          <LinkButton
            text="タイムライン"
            icon="mingcute:time-line"
            onClick={() => {}}
          />
        </li>
        <li className="mb-2">
          <LinkButton
            text="通知"
            icon="ion:notifications-outline"
            onClick={() => {}}
          />
        </li>
        <li className="mb-2">
          <LinkButton
            text="設定"
            icon="ion:settings-outline"
            onClick={() => {}}
          />
        </li>
      </ul>
    </nav>
  );
};

export default Component;
