import React, { useEffect, useState, FC } from 'react';
import Card from '../templates/Card';
import { useParams } from 'react-router-dom';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';

const Component: FC = () => {
  const [kind, setKind] = useState<string>('');
  const [name, setName] = useState<string>('');
  const [gender, setGender] = useState<string>('');
  const [age, setAge] = useState<number>(0);
  const [size, setSize] = useState<string>('');
  const [hair_length, setHairLength] = useState<string>('');

  const { id } = useParams();
  const { data, error } = useSWR<any>(
    `/api/animals?filters[id][$eq]=${id}`,
    fetchInstanceWithToken(),
  );

  useEffect(() => {
    if (!data) return;
    if (data.data.data[0].attributes.animal_kind.data)
      setKind(data.data.data[0].attributes.animal_kind.data.attributes.name);
    if (data.data.data[0].attributes.name)
      setName(data.data.data[0].attributes.name);
    if (data.data.data[0].attributes.gender)
      setGender(data.data.data[0].attributes.gender);
    if (data.data.data[0].attributes.age)
      setAge(data.data.data[0].attributes.age);
    if (data.data.data[0].attributes.size)
      setSize(data.data.data[0].attributes.size);
    if (data.data.data[0].attributes.hair_length)
      setHairLength(data.data.data[0].attributes.hair_length);
  }, [data]);

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  const animal = data.data.data[0];

  return (
    <>
      <Card>
        {animal.attributes.image ? (
          <img
            src={animal.attributes.image.data.attributes.url}
            alt="animal"
            className="w-full h-40 md:h-52 object-cover"
          />
        ) : (
          <div className="w-full h-40 md:h-52 flex justify-center items-center">
            <p className="text-gray-400">画像が登録されていません</p>
          </div>
        )}
      </Card>
      <div className="grid grid-cols-2 gap-2">
        <div className="flex gap-2 py-2 items-center">
          <p>名前：</p>
          <input
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>種類：</p>
          <input
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            type="text"
            value={kind}
            onChange={(e) => setKind(e.target.value)}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>性別：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            defaultValue={gender}
          >
            <option>オス</option>
            <option>メス</option>
            <option>不明</option>
          </select>
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>年齢：</p>
          <input
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            type="number"
            min="0"
            max="100"
            value={age}
            onChange={(e) => setName(e.target.value)}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>サイズ：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            defaultValue={size}
          >
            <option>小型</option>
            <option>中型</option>
            <option>大型</option>
          </select>
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>毛の長さ：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            defaultValue={hair_length}
          >
            <option>短め</option>
            <option>長め</option>
            <option>無毛</option>
          </select>
        </div>
      </div>
    </>
  );
};

export default Component;
