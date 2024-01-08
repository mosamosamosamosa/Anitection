import React, { useRef } from "react";
import { Icon } from '@iconify/react';
import { fetchInstanceWithToken } from "../../utils/fetchInstance";

import { useSelector } from "react-redux";
import { RootState } from "../../store";

const Component = () => {
  const { user } = useSelector((state: RootState) => state.user);
  const { institution } = useSelector((state: RootState) => state.institution);
  const inputRef = useRef<HTMLInputElement>(null);
  const [text, setText] = React.useState('');
  const [images, setImages] = React.useState<File[]>([]);

  const handleChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
    setText(event.target.value);
  }

  const handleImageChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (!event.target.files) return;
    if (event.target.files.length > 4) return;
    const files = Array.from(event.target.files);
    setImages(files);
  }

  const handleClick = () => {
    if (!inputRef.current) return;
    inputRef.current.click();
  }

  const handleRemove = (index: number) => {
    const newImages = images.filter((_, i) => i !== index);
    setImages(newImages);
  }

  const handleSubmit = () => {
    const instance = fetchInstanceWithToken();

    // strapiに送信する:まずは画像をjson形式で送信
    const formData = new FormData();
    images.forEach((image) => {
      formData.append('files', image);
    });

    instance.post('/api/upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    }).then((res) => {
      // 画像のidを取得
      const imageIds = res.data.map((image: any) => image.id);

      // 画像のidを含めてツイートを送信
      const body = {
        data: {
          content: text,
          images: imageIds,
          user: user.id,
          institution: institution.id,
        },
      };

      instance.post('/api/timelines', body);
    }).catch((err) => {
      console.log(err);
    });

    setText('');
    setImages([]);
  }

  return (
    <>
      {/* テキストエリア */}
      <div className="w-full bg-main rounded-md px-4 py-2 shadow-md border-2 border-main hover:shadow-lg relative hover:border-highlight">
        <textarea
          className="w-full h-40 resize-none bg-transparent focus:outline-none"
          placeholder="今何してる？"
          value={text}
          onChange={handleChange}
        ></textarea>

        {/* 画像 */}
        {images.length > 0 && (
          <div className="flex justify-start items-center gap-2 absolute bottom-2 left-2">
            {images.map((image, index) => (
              <div className="w-16 h-16 rounded-md overflow-hidden relative" key={index}>
                <img
                  src={URL.createObjectURL(image)}
                  alt="image"
                  className="w-full h-full object-cover"
                />
                <button className="absolute top-0.5 right-0.5 w-6 h-6 rounded-full bg-white flex justify-center items-center" onClick={() => handleRemove(index)}>
                  <Icon icon="ant-design:close-outlined" className="w-4 h-4" />
                </button>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* ボタン */}
      <div className="flex justify-between">
        <div className="flex">
          <button
            className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center"
            onClick={handleClick}
          >
            <Icon
              icon="ant-design:picture-outlined"
              className="w-8 h-8 p-1"
            />
          </button>
          <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
            <Icon
              icon="ant-design:smile-outlined"
              className="w-8 h-8 p-1"
            />
          </button>
          <button className="w-10 h-10 rounded-full hover:cursor-pointer hover:bg-white flex justify-center items-center">
            <Icon
              icon="ant-design:calendar-outlined"
              className="w-8 h-8 p-1"
            />
          </button>
          <input
            type="file"
            className="hidden"
            ref={inputRef}
            onChange={handleImageChange}
            multiple
          />
        </div>
        <button className="bg-highlight text-white rounded-md px-4 py-2 shadow-md hover:cursor-pointer hover:bg-white hover:text-highlight" onClick={handleSubmit}>
          ツイート
        </button>
      </div>
    </>
  );
}

export default Component;