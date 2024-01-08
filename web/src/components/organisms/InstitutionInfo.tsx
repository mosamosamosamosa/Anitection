import React, { FC } from 'react';
import Card from '../templates/Card';
import InfoHeader from '../atoms/InfoHeader';
import { Icon } from '@iconify/react';

import { useSelector } from 'react-redux';
import { RootState } from '../../store';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';

const Component: FC = () => {
  const { institution } = useSelector((state: RootState) => state.institution);
  const { data, error } = useSWR<any>(
    `/api/animals?filters[institution][id][$eq]=${institution.id}`,
    fetchInstanceWithToken(),
  );

  const countKinds = (array: any) => {
    const countMap: any = {};
    array.forEach((animal: any) => {
      countMap[animal] = (countMap[animal] || 0) + 1;
    });

    const result = Object.keys(countMap).map((key) => {
      return { name: key, number: countMap[key] };
    });

    return result;
  };

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  const animals = data.data.data;
  const count = animals.length;
  const kinds = animals.map((animal: any) => {
    if (!animal.attributes.animal_kind.data) {
      return '未登録';
    }
    return animal.attributes.animal_kind.data.attributes.name;
  });
  const kinds_count = countKinds(kinds);

  return (
    <>
      {/* 施設情報 */}
      <InfoHeader icon="ion:home-outline" title="施設情報" />
      <Card>
        <div className="w-full flex justify-center items-center">
          <ul className="flex flex-col gap-2 py-2">
            <li className="flex gap-2 items-center">
              <Icon icon="akar-icons:home" className="w-4 h-4 mr-1" />
              {institution.attributes.name}
            </li>
            <li className="flex gap-2 items-center">
              <Icon icon="akar-icons:location" className="w-4 h-4 mr-1" />
              {institution.attributes.address}
            </li>
            <li className="flex gap-2 items-center">
              <Icon icon="akar-icons:phone" className="w-4 h-4 mr-1" />
              {institution.attributes.phone}
            </li>
          </ul>
        </div>
        <div className="absolute bottom-2 right-4 flex justify-end items-end">
          <p className="text-sm">詳細へ</p>
          <Icon icon="tdesign:swap-right" className="w-6" />
        </div>
      </Card>
      {/* 動物情報 */}
      <InfoHeader icon="cil:animal" title="動物情報" />
      <Card>
        <div className="w-full flex justify-center items-center">
          <ul className="flex flex-col gap-2 py-2">
            <li className="flex gap-2 items-center">
              <Icon icon="cil:animal" className="w-4 h-4 mr-1" />
              総数：{count}匹
            </li>
            {kinds_count.map((item: any, index: number) => (
              <li key={index} className="flex gap-2 items-center">
                {item.name}：{item.number}匹
              </li>
            ))}
          </ul>
        </div>
        <div className="absolute bottom-2 right-4 flex justify-center items-center">
          <Icon icon="tdesign:swap-right" className="mt-1 w-6" />
        </div>
      </Card>
    </>
  );
};

export default Component;
