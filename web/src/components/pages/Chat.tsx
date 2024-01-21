import React, { useEffect, useState } from 'react';
import TalkBubble from '../organisms/TalkBubble';
import Layout from '../templates/Layout';
import cat from '../../assets/cat.png';
import { Icon } from '@iconify/react';

import Navigation from '../organisms/Navigation';
import InstitutionInfo from '../organisms/InstitutionInfo';

const Chat: React.FC = () => {
  const [messages, setMessages] = useState<string[]>([]);
  const [senders, setSenders] = useState<string[]>([]);

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
  }, []);

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-3 lg:col-span-2 lg:block">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4">
          <div className="w-full h-full flex flex-col gap-6 px-0 py-2">
            <ul>
              {messages.map((content, index) => (
                <TalkBubble
                  key={index}
                  imageUrl={cat}
                  content={content}
                  userName={senders[index]}
                />
              ))}
            </ul>

            <form className="flex justify-center items-center gap-2">
              <input
                className="w-full h-10 px-3 rounded-full border border-gray-300 focus:outline-none"
                type="text"
                placeholder="メッセージを入力"
              />
              <button className="w-10 h-10 rounded-full bg-blue-500 hover:bg-blue-600 focus:outline-none flex justify-center items-center">
                <Icon icon="ant-design:arrow-right-outlined" className="w-6" />
              </button>
            </form>
          </div>
        </div>

        {/* 情報 */}
        <div className="hidden md:block col-span-12 md:col-span-4 lg:col-span-3 space-y-4">
          <InstitutionInfo />
        </div>
      </div>
    </Layout>
  );
};

export default Chat;
