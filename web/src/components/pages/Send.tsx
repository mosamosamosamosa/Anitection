import React, { useState } from 'react';
import Layout from '../templates/Layout';

import Navigation from '../organisms/Navigation';

import InfoHeader from '../atoms/InfoHeader';
import Card from '../templates/Card';
import Button from '../atoms/Button';
import { Icon } from '@iconify/react';
import Modal from '../templates/Modal';

const Chat: React.FC = () => {
  const [donationAmount, setDonationAmount] = useState<number | null>(null);
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);

  // Function to handle donation button click
  const handleDonationButtonClick = (amount: number) => {
    setDonationAmount(amount);
  };

  // Function to handle donate button click
  const handleDonateButtonClick = () => {
    // Perform the donation or any other action here
    if (donationAmount !== null) {
      setIsModalOpen(true);
    } else {
      alert('Please select a donation amount');
    }
  };

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden col-span-12 md:col-span-3 lg:col-span-2 lg:block">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4">
          <Card>
            <div className="w-full flex justify-center items-center py-8 px-2">
              <img
                src="https://jspca.or.jp/common/img/img_mainvisual01.jpg"
                alt="animal"
                className="w-full object-cover"
              />
            </div>
            <div className="w-full flex justify-center items-center gap-2 py-8">
              {[100, 500, 1000, 3000, 5000, 10000].map((amount) => (
                <Button
                  key={amount}
                  icon="bx:bx-coin-stack"
                  onClick={() => handleDonationButtonClick(amount)}
                  text={amount.toString()}
                  highlight={donationAmount === amount}
                />
              ))}
            </div>
            <div className="flex justify-center items-center py-4">
              <Button
                text="寄付する"
                icon="bx:bx-coin-stack"
                onClick={handleDonateButtonClick}
                highlight
              />
            </div>
          </Card>
          {/* Donate button */}
        </div>

        {/* 情報 */}
        <div className="hidden md:block col-span-12 md:col-span-4 lg:col-span-3 space-y-4">
          {/* ポイント */}
          <InfoHeader icon="bx:bx-coin-stack" title="ポイント" />
          <Card>
            <div className="w-full flex justify-center items-center">
              <ul className="flex flex-col gap-2 py-2 w-full">
                {/* 現在のポイント */}
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                  <p className="text-sm">保有ポイント：</p>
                  <p>1000</p>
                </li>
                {/* いままでの寄付金額 */}
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                  <p className="text-sm">寄付金額：</p>
                  <p>3500</p>
                </li>
              </ul>
            </div>
          </Card>
        </div>
      </div>

      {/* Modal */}
      {isModalOpen && (
        <Modal text="寄付が完了しました" onClick={() => setIsModalOpen(false)}>
          {/* 送金ポイントを表示 */}
          <div className="flex justify-center items-center gap-2 py-8">
            <ul className="flex flex-col gap-2 py-2">
              <li className="flex gap-2 items-center text-4xl">
                <Icon icon="bx:bx-coin-stack" className="w-8 h-8 mr-1" />
                <p>{donationAmount} ポイント</p>
              </li>
              <li className="text-sm flex justify-end items-center">
                寄付ありがとう！
              </li>
            </ul>
          </div>
        </Modal>
      )}
    </Layout>
  );
};

export default Chat;
