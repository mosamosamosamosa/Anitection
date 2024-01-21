import React, { useState } from 'react';
import Layout from '../templates/Layout';

import Navigation from '../organisms/Navigation';

import InfoHeader from '../atoms/InfoHeader';
import Card from '../templates/Card';
import Button from '../atoms/Button';
import { Icon } from '@iconify/react';

const Chat: React.FC = () => {
  const [donationAmount, setDonationAmount] = useState<number | null>(null);

  // Function to handle donation button click
  const handleDonationButtonClick = (amount: number) => {
    setDonationAmount(amount);
  };

  // Function to handle donate button click
  const handleDonateButtonClick = () => {
    // Perform the donation or any other action here
    if (donationAmount !== null) {
      console.log(`Donating ${donationAmount} yen`);
      // You can perform the actual donation logic here
    } else {
      console.log('Please select a donation amount');
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
          {/* 現在の保有ポイント */}
          <InfoHeader icon="bx:bx-coin-stack" title="現在の保有ポイント" />
          <Card>
            <div className="w-full flex justify-center items-center">
              <ul className="flex flex-col gap-2 py-2">
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                  <p>1000</p>
                </li>
              </ul>
            </div>
          </Card>
          {/* 現在の寄付金額 */}
          <InfoHeader icon="bx:bx-coin-stack" title="現在の寄付金額" />
          <Card>
            <div className="w-full flex justify-center items-center">
              <ul className="flex flex-col gap-2 py-2">
                <li className="flex gap-2 items-center">
                  <Icon icon="bx:bx-coin-stack" className="w-4 h-4 mr-1" />
                  <p>3500</p>
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
