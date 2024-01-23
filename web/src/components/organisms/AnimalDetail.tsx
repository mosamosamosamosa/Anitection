import React, { useEffect, useState, FC } from 'react';
import { Link, useParams } from 'react-router-dom';
import Button from '../atoms/Button';
import Card from '../templates/Card';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';

const Component: FC = () => {
  const [kind, setKind] = useState<string>('');
  const [name, setName] = useState<string>('');
  const [gender, setGender] = useState<string>('');
  const [age, setAge] = useState<number>(0);
  const [size, setSize] = useState<string>('');
  const [hair_length, setHairLength] = useState<string>('');
  const [personality, setPersonality] = useState<string>('');
  const [interest, setInterest] = useState<string>('');
  const [description, setDescription] = useState<string>('');
  const [pattern, setPattern] = useState<string>('');
  const [pedigree, setPedigree] = useState<string>('');

  const { id } = useParams();
  const { data, error } = useSWR<any>(
    `/api/animals?filters[id][$eq]=${id}`,
    fetchInstanceWithToken(),
  );

  const { data: kinds } = useSWR<any>(
    '/api/animal-kinds',
    fetchInstanceWithToken(),
  );

  const { data: patterns } = useSWR<any>(
    '/api/patterns',
    fetchInstanceWithToken(),
  );

  const { data: pedigrees } = useSWR<any>(
    '/api/pedigrees',
    fetchInstanceWithToken(),
  );

  useEffect(() => {
    if (!data) return;
    const animal = data.data.data[0].attributes;
    if (animal.animal_kind.data)
      setKind(animal.animal_kind.data.attributes.name);
    if (animal.name) setName(animal.name);
    if (animal.gender) setGender(animal.gender);
    if (animal.age) setAge(animal.age);
    if (animal.size) setSize(animal.size);
    if (animal.hair_length) setHairLength(animal.hair_length);
    if (animal.personality) setPersonality(animal.personality);
    if (animal.interest) setInterest(animal.interest);
    if (animal.description) setDescription(animal.description);
    if (animal.pattern.data) setPattern(animal.pattern.data.attributes.name);
    if (animal.pedigree.data) setPedigree(animal.pedigree.data.attributes.name);
  }, [data]);

  const handleSubmit = () => {
    const instance = fetchInstanceWithToken();
    // const formData = new FormData();

    const body = {
      data: {
        animal_kind: animal_kinds.find(
          (item: any) => item.attributes.name === kind,
        ).id,
        name: name,
        gender: gender,
        age: age,
        size: size,
        hair_length: hair_length,
        personality: personality,
        interest: interest,
        description: description,
        pattern: pattern
          ? animal_patterns.find(
              (item: any) => item.attributes.name === pattern,
            ).id
          : null,
        pedigree: pedigree
          ? animal_pedigrees.find(
              (item: any) => item.attributes.name === pedigree,
            ).id
          : null,
      },
    };

    instance
      .put(`/api/animals/${id}`, body)
      .then(() => {
        // reload
        window.location.reload();
      })
      .catch((err) => {
        console.log(err.response);
      });
  };

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;
  if (!kinds) return <div>loading...</div>;
  if (!patterns) return <div>loading...</div>;
  if (!pedigrees) return <div>loading...</div>;

  const animal = data.data.data[0];
  const animal_kinds = kinds.data.data;
  const animal_patterns = patterns.data.data;
  const animal_pedigrees = pedigrees.data.data;

  return (
    <>
      <Card>
        <Link to={`/register/${id}`}>
          <div className="min-h-[200px]">
            {animal.attributes.avatar_icon.data && (
              <img
                src={`${process.env.REACT_APP_API_URL}${animal.attributes.avatar_icon.data.attributes.url}`}
                alt="animal"
                className="w-full h-full object-cover rounded-md"
              />
            )}
          </div>
        </Link>
      </Card>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
        <div className="flex gap-2 py-2 items-center">
          <p>名前：</p>
          <input
            className="w-4/6 rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>種類：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            onChange={(e) => setKind(e.target.value)}
            value={kind}
          >
            {animal_kinds.map((item: any, index: number) => (
              <option key={index}>{item.attributes.name}</option>
            ))}
          </select>
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>性別：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            onChange={(e) => setGender(e.target.value)}
            value={gender}
          >
            {['オス', 'メス', '不明'].map((item, index) => (
              <option key={index}>{item}</option>
            ))}
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
            onChange={(e) => setAge(Number(e.target.value))}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>サイズ：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            onChange={(e) => setSize(e.target.value)}
            value={size}
          >
            {['小さめ', '標準', '大きめ'].map((item, index) => (
              <option key={index}>{item}</option>
            ))}
          </select>
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>毛の長さ：</p>
          <select
            className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            onChange={(e) => setHairLength(e.target.value)}
            value={hair_length}
          >
            {['短め', '長め', '無毛'].map((item, index) => (
              <option key={index}>{item}</option>
            ))}
          </select>
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>性格：</p>
          <input
            className="w-4/6 rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            type="text"
            value={personality}
            onChange={(e) => setPersonality(e.target.value)}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>興味：</p>
          <input
            className="w-4/6 rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            type="text"
            value={interest}
            onChange={(e) => setInterest(e.target.value)}
          />
        </div>
        <div className="flex gap-2 py-2 items-center">
          <p>説明：</p>
          <textarea
            className="w-4/6 rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          ></textarea>
        </div>
        {kind === '猫' && (
          <div className="flex gap-2 py-2 items-center">
            <p>柄：</p>
            <select
              className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
              value={pattern}
              onChange={(e) => setPattern(e.target.value)}
            >
              {animal_patterns.map((item: any) => (
                <option key={item.id}>{item.attributes.name}</option>
              ))}
            </select>
          </div>
        )}
        {kind === '犬' && (
          <div className="flex gap-2 py-2 items-center">
            <p>血統書：</p>
            <select
              className="rounded-md p-2 shadow-md focus:ring-2 focus:ring-highlight focus:outline-none"
              value={pedigree}
              onChange={(e) => setPedigree(e.target.value)}
            >
              {animal_pedigrees.map((item: any) => (
                <option key={item.id}>{item.attributes.name}</option>
              ))}
            </select>
          </div>
        )}
      </div>
      <div className="flex justify-end items-center py-4">
        <Button
          text="更新"
          icon="ant-design:edit-outlined"
          onClick={handleSubmit}
          highlight
        />
      </div>
    </>
  );
};

export default Component;
