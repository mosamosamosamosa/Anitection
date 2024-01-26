import React from 'react';

interface TalkBubbleProps {
  content: string;
  imageUrl: string;
  userName: string;
}

const TalkBubble: React.FC<TalkBubbleProps> = ({
  imageUrl,
  content,
  userName,
}) => {
  return (
    <li>
      <div
        className={`flex w-full ${
          userName === 'hoge' ? 'flex-row-reverse' : ''
        }`}
      >
        <div
          className={`mt-6 mx-10 inline-block relative w-auto h-auto rounded-xl shadow-md ${
            userName === 'hoge' ? 'bg-highlight' : 'bg-white'
          }`}
        >
          <div className="p-4 text-left leading-6 flex">
            <img
              src={imageUrl}
              alt="User"
              className="w-10 h-10 mr-5 mt-1 rounded-full border border-black object-cover"
            />
            <div className="w-full">
              <p>{content}</p>
              <div className="float-right">
                <p>{userName}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </li>
  );
};

export default TalkBubble;
