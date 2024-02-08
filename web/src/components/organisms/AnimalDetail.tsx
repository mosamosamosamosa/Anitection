import React, { useEffect, useState, FC } from 'react';
import { Link, useParams } from 'react-router-dom';
import Button from '../atoms/Button';
import Card from '../templates/Card';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import Text from '../atoms/Text';
import { Icon } from '@iconify/react';
import Lottie from 'react-lottie';
import blinkCat from '../../assets/lottie/blink_cat2.json';
import blinkDog from '../../assets/lottie/blink_dog.json';
import InfoHeader from '../atoms/InfoHeader';

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

  const defaultOptions = {
    loop: true,
    autoplay: true,
    rendererSettings: {
      preserveAspectRatio: 'xMidYMid slice',
    },
  };

  const [width, setWidth] = React.useState<number>(window.innerWidth);
  useEffect(() => {
    const handleResize = () => setWidth(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

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
      {/* 動物 */}
      <div className="col-span-12 md:col-span-8 lg:col-span-7 space-y-4">
        <>
          <Card>
            <div className="flex gap-2 py-2 items-center text-2xl">
              <Text
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="名前を入力"
              />
            </div>
            <div className="min-h-[200px] bg-neutral-100 rounded-md relative">
              <Link to={`/register/${id}`}>
                {animal.attributes.avatar_icon.data && (
                  <div className="relative w-full h-full group">
                    <img
                      src={`${process.env.REACT_APP_API_URL}${animal.attributes.avatar_icon.data.attributes.url}`}
                      alt="animal"
                      className="w-full h-full object-cover rounded-md"
                    />
                    {animal.attributes.sitting ? (
                      <div className="absolute -top-12 -left-3 md:-top-24 md:-left-6 lg:-top-24 lg:-left-7 w-full h-full flex justify-center items-center">
                        <Lottie
                          options={{...defaultOptions, animationData: blinkDog}}
                          height={width > 1024 ? 540 : width > 480 ? 500 : 240}
                          width={width > 1024 ? 540 : width > 480 ? 500 : 240}
                        />
                      </div>
                    ) : (
                      <div className="absolute top-5 left-2 md:top-10 md:left-5 w-full h-full flex justify-center items-center">
                        <Lottie
                          options={{...defaultOptions, animationData: blinkCat}}
                          height={width > 1024 ? 640 : width > 480 ? 560 : 280}
                          width={width > 1024 ? 640 : width > 480 ? 560 : 280}
                        />
                      </div>
                    )}
                  </div>
                )}
                <div className="absolute top-0 left-0 w-full h-full bg-black bg-opacity-50 rounded-md flex justify-center items-center opacity-0 group-hover:opacity-100 transition-all duration-300">
                  <Icon
                    icon="ant-design:edit-outlined"
                    className="w-12 h-12 text-white"
                  />
                </div>
              </Link>
            </div>
          </Card>
          <Card>
            <div className="grid grid-cols-1 md:grid-cols-2">
              <div className="flex gap-2 py-2 items-center">
                <p>種類：</p>
                <select
                  className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
                  className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
                  className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
                  className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
                  className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
                <Text
                  value={personality}
                  onChange={(e) => setPersonality(e.target.value)}
                  placeholder="性格を入力"
                />
              </div>
              <div className="flex gap-2 py-2 items-center">
                <p>興味：</p>
                <Text
                  value={interest}
                  onChange={(e) => setInterest(e.target.value)}
                  placeholder="興味を入力"
                />
              </div>
              <div className="flex gap-2 py-2 items-center">
                <p>説明：</p>
                <textarea
                  className="w-4/6 rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                ></textarea>
              </div>
              {kind === '猫' && (
                <div className="flex gap-2 py-2 items-center">
                  <p>柄：</p>
                  <select
                    className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
                    className="rounded-md p-2 bg-neutral-100 focus:ring-2 focus:ring-highlight focus:outline-none"
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
          </Card>
        </>
      </div>

      {/* 情報 */}
      <div className="hidden md:block col-span-12 md:col-span-4 lg:col-span-3 space-y-4">
        <InfoHeader icon="ion:information-circle-outline" title="アイコン" />
        <Card>
          <div className="min-h-[200px] bg-neutral-100 rounded-md relative group">
            {animal.attributes.real_icon.data && (
              <img
                src={`${process.env.REACT_APP_API_URL}${animal.attributes.real_icon.data.attributes.url}`}
                alt="animal"
                className="w-full h-full object-cover rounded-md"
              />
            )}
            <div className="absolute top-0 left-0 w-full h-full bg-black bg-opacity-50 rounded-md flex justify-center items-center opacity-0 group-hover:opacity-100 transition-all duration-300">
              <Icon
                icon="ant-design:edit-outlined"
                className="w-12 h-12 text-white"
              />
            </div>
          </div>
        </Card>
        {/* 画像 */}
        <InfoHeader icon="ion:images-outline" title="画像" />
        <div className="grid grid-cols-1 gap-2">
          {animal.attributes.images.data &&
            animal.attributes.images.data.map((image: any) => (
              <Card key={image.id}>
                <div className="min-h-[200px] bg-neutral-100 rounded-md relative group">
                  <img
                    src={`${process.env.REACT_APP_API_URL}${image.attributes.url}`}
                    alt="animal"
                    className="w-full h-full object-cover rounded-md"
                  />
                  <div className="absolute top-0 left-0 w-full h-full bg-black bg-opacity-50 rounded-md flex justify-center items-center opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <Icon
                      icon="ant-design:edit-outlined"
                      className="w-12 h-12 text-white"
                    />
                  </div>
                </div>
              </Card>
            ))}
          <Card>
            <button className="w-full h-20 flex justify-center items-center">
              <Icon icon="ant-design:plus-outlined" className="w-12 h-12" />
            </button>
          </Card>
        </div>
      </div>
    </>
  );
};

export default Component;
