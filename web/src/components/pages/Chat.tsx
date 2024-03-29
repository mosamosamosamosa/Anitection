import React, { useEffect, useState } from 'react';
import TalkBubble from '../organisms/TalkBubble';
import Layout from '../templates/Layout';
import cat from '../../assets/cat.png';
import Button from '../atoms/Button';

import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import Navigation from '../organisms/Navigation';
import InfoHeader from '../atoms/InfoHeader';
import Card from '../templates/Card';
import { Icon } from '@iconify/react';

const Chat: React.FC = () => {
  const [messages, setMessages] = useState<string[]>([]);
  const [senders, setSenders] = useState<string[]>([]);
  const [value, setValue] = useState<string>('');

  const handleSubmit = () => {
    const instance = fetchInstanceWithToken();
    instance
      .post('/api/messages', {
        data: {
          content: value,
          institution: 1,
          sender: 1,
          recipient: 2,
        },
      })
      .then(() => {
        window.location.reload();
      })
      .catch((err) => console.error(err));
    setValue('');
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(
          'https://anitection-api.yumekiti.net/api/messages?filters[institution][id][$eq]=1',
        );

        if (!response.ok) {
          throw new Error('404');
        }

        const { data } = await response.json();

        const fetchedMessages = data.map(
          (message: any) => message.attributes.content,
        );
        const fetchedSenders = data.map(
          (message: any) => message.attributes.sender.data.attributes.username,
        );

        setMessages(fetchedMessages);
        setSenders(fetchedSenders);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();

    setTimeout(() => {
      const bottomElement = document.getElementById('bottom');
      if (!bottomElement) return;
      bottomElement.scrollTo(0, bottomElement.scrollHeight);
    }, 1000);
  }, []);

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-3 lg:col-span-2 lg:block">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4 bg-neutral-50 shadow-md rounded-md">
          <div className="w-full flex flex-col gap-6 px-0 py-2 h-[75vh]">
            <ul
              className="flex flex-col h-5/6 gap-4 overflow-y-scroll py-2 scroll-smooth"
              id="bottom"
            >
              {messages.map((content, index) => (
                <TalkBubble
                  key={index}
                  imageUrl={cat}
                  content={content}
                  userName={senders[index]}
                />
              ))}
            </ul>
            <div className="flex justify-center items-center gap-2 h-3%">
              <input
                className="w-full h-10 px-3 ml-3 rounded-full border border-gray-300 focus:outline-none"
                type="text"
                placeholder="メッセージを入力"
                value={value}
                onChange={(e) => setValue(e.target.value)}
              />
              <div className="flex justify-center mr-3 items-center w-2/12">
                <Button
                  text="送信"
                  icon="bx:bx-send"
                  onClick={handleSubmit}
                  highlight
                />
              </div>
            </div>
          </div>
        </div>

        {/* 情報 */}
        <div className="hidden md:block col-span-12 md:col-span-4 lg:col-span-3 space-y-4">
          <InfoHeader icon="ion:home-outline" title="ユーザー情報" />
          <Card>
            <div className="w-full flex justify-center items-center">
              <ul className="flex flex-col gap-2 py-2">
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-user" className="w-4 h-4 mr-1" />
                  hogeさん
                </li>
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                  保有ポイント：5000
                </li>
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                  寄付金額：3000
                </li>
                {/* プレイ時間 */}
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-time" className="w-4 h-4 mr-1" />
                  プレイ時間：10時間
                </li>
              </ul>
            </div>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Chat;
