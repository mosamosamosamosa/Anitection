import React, { useEffect } from 'react';
import Card from '../templates/Card';
import { Icon } from '@iconify/react';
import { Link } from 'react-router-dom';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';

import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import Text from '../atoms/Text';

const Component: React.FC = () => {
  const [animals, setAnimals] = React.useState<any[]>([]);
  const [search, setSearch] = React.useState<string>('');
  const { institution } = useSelector((state: RootState) => state.institution);
  const { data, error } = useSWR<any>(
    `/api/animals?filters[institution][id][$eq]=${institution.id}`,
    fetchInstanceWithToken(),
  );

  useEffect(() => {
    if (!data) return;
    setAnimals(data.data.data);
  }, [data]);

  const handleSearch = (event: React.ChangeEvent<HTMLInputElement>) => {
    setSearch(event.target.value);
    const result = data.data.data.filter((animal: any) =>
      animal.attributes.name.includes(event.target.value),
    );
    setAnimals(result);
  };

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  return (
    <>
      <div className="flex items-center gap-4">
        <Text value={search} onChange={handleSearch} placeholder="名前を入力" />
        {/* ソート */}
        <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
          <Icon icon="icon-park:sort-one" className="w-8 h-8 p-1" />
        </button>
      </div>
      <div className="grid grid-cols-12 gap-4">
        <div className="col-span-6">
          <Card>
            <Link
              to={'/register'}
              className="w-full h-40 md:h-52 flex justify-center items-center"
            >
              <Icon icon="ant-design:plus-outlined" className="w-12 h-12" />
            </Link>
          </Card>
        </div>
        {animals.map((animal: any, index: number) => (
          <Link to={`/${animal.id}`} key={index} className="col-span-6">
            <Card>
              <div className="w-full h-40 md:h-52">
                {animal.attributes.avatar_icon.data && (
                  <img
                    src={`${process.env.REACT_APP_API_URL}${animal.attributes.avatar_icon.data.attributes.url}`}
                    alt=""
                    className="w-full h-5/6 object-contain"
                  />
                )}
                <div className="w-full h-1/6 flex justify-center items-center">
                  <p className="text-center text-lg">
                    {animal.attributes.name}
                  </p>
                </div>
              </div>
            </Card>
          </Link>
        ))}
      </div>
    </>
  );
};

export default Component;
