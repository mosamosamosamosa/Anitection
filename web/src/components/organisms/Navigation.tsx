import React from 'react';
import LinkButton from '../atoms/LinkButton';

const Component = () => {
  return (
    <nav>
      <ul>
        <li className="mb-2">
          <LinkButton text="ホーム" icon="ion:home-outline" onClick={() => {}} />
        </li>
        <li className="mb-2">
          <LinkButton text="タイムライン" icon="mingcute:time-line" onClick={() => {}} />
        </li>
        {/* 他のナビゲーション項目を追加 */}
      </ul>
    </nav>
  );
};

export default Component;
