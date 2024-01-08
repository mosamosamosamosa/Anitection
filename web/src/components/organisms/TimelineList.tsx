import React, { FC, useState } from 'react';
import useSWR from 'swr';
import {
  fetchInstance,
  fetchInstanceWithToken,
} from '../../utils/fetchInstance';
import Card from '../templates/Card';
import { Icon } from '@iconify/react';
import ImageModal from '../templates/ImageModal';

const Component: FC = () => {
  const [imageSrc, setImageSrc] = useState<string>('');
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [footprintsFlagIds, setFootprintsFlagIds] = useState<number[]>([]);
  const { data, error } = useSWR<any>(
    `/api/timelines`,
    fetchInstanceWithToken(),
  );

  const handleOpen = (src: string) => {
    setIsOpen(true);
    setImageSrc(src);
  };

  const handleClose = () => {
    setIsOpen(false);
  };

  const handleFootprints = (id: number, footprints: number) => {
    if (footprintsFlagIds.includes(id)) return;
    setFootprintsFlagIds([...footprintsFlagIds, id]);

    const body = {
      data: {
        footprints: footprints + 1,
      },
    };

    fetchInstance().put(`/api/timelines/${id}`, body);
  };

  if (error) return <div>failed to load</div>;
  if (!data) return <div>loading...</div>;

  const timelines = data.data.data;

  return (
    <>
      {timelines.map((timeline: any) => (
        <Card key={timeline.id}>
          <div
            className="w-full h-full py-2"
            onMouseEnter={() =>
              handleFootprints(timeline.id, timeline.attributes.footprints)
            }
          >
            {/* user info  */}
            <div className="flex justify-start items-center gap-2">
              <Icon icon="ant-design:user-outlined" className="w-10 h-10" />
              <div className="flex flex-col overflow-hidden whitespace-nowrap">
                <p className="text-md font-semibold">
                  {timeline.attributes.institution.data.attributes.name}
                </p>
                <p className="text-sm text-gray-500">
                  {timeline.attributes.user.data.attributes.email}
                </p>
              </div>
            </div>
            {/* post content */}
            <div className="w-full h-full flex flex-col md:flex-row gap-4 px-0 md:px-12 py-2">
              {timeline.attributes.images.data.length > 0 && (
                <div
                  className={`w-full md:w-2/3 grid gap-2 ${
                    timeline.attributes.images.data.length === 1
                      ? 'grid-cols-1'
                      : 'grid-cols-2'
                  }`}
                >
                  {timeline.attributes.images.data.map((image: any) => (
                    <div
                      key={image.id}
                      className="flex justify-center items-center"
                    >
                      <img
                        className="w-full h-full object-cover border border-gray-300 rounded-md"
                        src={`${process.env.REACT_APP_API_URL}${image.attributes.url}`}
                        alt="timeline"
                        onClick={() =>
                          handleOpen(
                            `${process.env.REACT_APP_API_URL}${image.attributes.url}`,
                          )
                        }
                      />
                      {isOpen && (
                        <ImageModal onClick={handleClose}>
                          <img
                            className="w-full h-full object-cover border border-gray-300 rounded-md"
                            src={imageSrc}
                            alt="timeline"
                          />
                        </ImageModal>
                      )}
                    </div>
                  ))}
                </div>
              )}
              <div className="w-full md:w-1/3 h-full">
                <p>{timeline.attributes.content}</p>
              </div>
            </div>
            {/* post info */}
            <div className="flex justify-between items-center gap-4 px-0 md:px-12 py-2">
              <div className="flex justify-center items-center gap-2">
                <Icon
                  icon="ant-design:clock-circle-outlined"
                  className="w-4 h-4"
                />
                <p className="text-sm text-gray-500">
                  {new Date(timeline.attributes.createdAt).toLocaleString()}
                </p>
              </div>
              <div className="flex justify-center items-center gap-2">
                <Icon
                  icon="fluent-emoji-high-contrast:paw-prints"
                  className="w-4 h-4"
                />
                <p className="text-sm text-gray-500">
                  {timeline.attributes.footprints}
                </p>
              </div>
            </div>
          </div>
        </Card>
      ))}
    </>
  );
};

export default Component;
