import React from 'react';
import Layout from '../templates/Layout';
import Card from '../templates/Card';
import InfoHeader from '../atoms/InfoHeader';

const Component = () => {
  return (
    <Layout>
      <div className="grid grid-cols-12 gap-4">
        <div className="col-span-12 md:col-span-4">
          <div className="mb-4 flex">
            <InfoHeader icon="ion:home-outline" title="施設情報" />
          </div>
          <div className="mb-4">
            <Card>
              <div className="w-full h-40">contents</div>
              <div className="absolute bottom-2 right-4 flex justify-center items-center">
                <h2 className="text-sm">詳細へ</h2>
              </div>
            </Card>
          </div>
        </div>
        <div className="col-span-12 md:col-span-8">
          <div className="mb-4 flex">
            <InfoHeader icon="cil:animal" title="動物情報" />
          </div>
          <div className="mb-4">
            <Card>
              <div className="w-full h-40">contents</div>
            </Card>
          </div>
        </div>
        <div className="col-span-12">
          <div className="mb-4 flex">
            <InfoHeader icon="maki:animal-shelter" title="動物一覧" />
          </div>
          <div className="mb-4 flex items-center gap-4">
            <input
              type="text"
              className="w-1/2 h-12 rounded-md px-4 py-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
              placeholder="動物名を入力してください"
            />
            <div className="w-12 h-12 rounded-full bg-white border-4"></div>
          </div>
          <div className="mb-4">
            <div className="grid grid-cols-12 gap-4">
              {[...Array(24)].map((_, index: number) => {
                return index === 0 ? (
                  <div key={index} className="col-span-12 md:col-span-2">
                    <Card>
                      <div className="w-full h-40">plus</div>
                    </Card>
                  </div>
                ) : (
                  <div key={index} className="col-span-12 md:col-span-2">
                    <Card>
                      <div className="w-full h-40">contents</div>
                    </Card>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
