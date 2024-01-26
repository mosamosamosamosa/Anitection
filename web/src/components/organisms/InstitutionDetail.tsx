import React, { FC, useRef, useState } from 'react';
import Card from '../templates/Card';
import { Icon } from '@iconify/react';

import { useSelector } from 'react-redux';
import { RootState } from '../../store';

import useSWR from 'swr';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import Button from '../atoms/Button';
import Text from '../atoms/Text';

const Component: FC = () => {
  const { institution } = useSelector((state: RootState) => state.institution);
  const { data, error } = useSWR<any>(
    `/api/animals?filters[institution][id][$eq]=${institution.id}`,
    fetchInstanceWithToken(),
  );

  const [name, setName] = useState<string>(institution.attributes.name);
  const [address, setAddress] = useState<string>(
    institution.attributes.address,
  );
  const [phone, setPhone] = useState<string>(institution.attributes.phone);
  const [description, setDescription] = useState<string>(
    institution.attributes.description,
  );
  const [website_url, setWebsiteUrl] = useState<string>(
    institution.attributes.website_url,
  );
  const [needs_url, setNeedsUrl] = useState<string>(
    institution.attributes.needs_url,
  );
  const [image, setImage] = useState<File>();
  const [image_url, setImageUrl] = useState<string>(
    `${process.env.REACT_APP_API_URL}${institution.attributes.image.data.attributes.url}`,
  );
  const imageFile = useRef<HTMLInputElement>(null);

  const handleSubmit = () => {
    const instance = fetchInstanceWithToken();
    const formData = new FormData();
    if (image) {
      formData.append('files', image);
    }

    if (image) {
      instance
        .post('/api/upload', formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        })
        .then((res) => {
          if (res.status === 200) {
            const imageID = res.data[0].id;
            const body = {
              data: {
                name: name,
                address: address,
                phone: phone,
                description: description,
                website_url: website_url,
                needs_url: needs_url,
                image: imageID,
              },
            };

            instance
              .put(`/api/institutions/${institution.id}`, body)
              .then((res) => {
                if (res.status === 200) {
                  window.location.reload();
                }
              });
          }
        });
    } else {
      const body = {
        data: {
          name: name,
          address: address,
          phone: phone,
          description: description,
          website_url: website_url,
          needs_url: needs_url,
        },
      };

      instance.put(`/api/institutions/${institution.id}`, body).then((res) => {
        if (res.status === 200) {
          window.location.reload();
        }
      });
    }
  };

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
      <Card>
        <input
          type="file"
          ref={imageFile}
          className="hidden"
          onChange={(e) => {
            if (!e.target.files) return;
            const file = e.target.files[0];
            setImage(file);
            setImageUrl(URL.createObjectURL(file));
          }}
        />
        <div className="w-full flex flex-col gap-2 py-4 px-4">
          <div className="text-2xl">
            <Text
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="施設名"
            />
          </div>
          <div className="text-sm w-full flex justify-start items-center gap-2">
            <Icon
              icon="fluent:arrow-enter-left-20-filled"
              className="w-4 h-4 mr-1 -scale-x-100"
            />
            <Text
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="施設の説明"
            />
          </div>
          <img
            className="rounded-2xl"
            src={image_url}
            alt="institution_place"
            onClick={() => imageFile.current?.click()}
          />
          <div className="flex gap-2 items-center">
            <Icon icon="akar-icons:location" className="w-4 h-4 mr-1" />
            <Text
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              placeholder="住所"
            />
          </div>
          <div className="flex gap-2 items-center">
            <Icon icon="akar-icons:phone" className="w-4 h-4 mr-1" />
            <Text
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
              placeholder="電話番号"
            />
          </div>
          <div className="flex gap-2 items-center">
            <Icon icon="streamline:web" className="w-4 h-4 mr-1" />
            <Text
              value={website_url}
              onChange={(e) => setWebsiteUrl(e.target.value)}
              placeholder="ホームページ"
            />
          </div>
          <div className="flex gap-2 items-center">
            <Icon icon="mdi:shopping-outline" className="w-4 h-4 mr-1" />
            <Text
              value={needs_url}
              onChange={(e) => setNeedsUrl(e.target.value)}
              placeholder="支援物資"
            />
          </div>
          <div className="flex gap-2 items-center">
            <Icon icon="cil:animal" className="w-4 h-4 mr-1" />
            総数：{count}匹
          </div>
          {kinds_count.map((item: any, index: number) => (
            <div key={index} className="flex gap-2 items-center">
              <Icon icon="ph:info" className="w-4 h-4 mr-1" />
              {item.name}：{item.number}匹
            </div>
          ))}
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
  );
};

export default Component;
