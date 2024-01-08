import React, { useEffect, useState } from 'react';
import cat from '../../assets/cat.png';
import Card from '../templates/Card';
import Layout from '../templates/Layout';
import Button from '../atoms/Button';
import Navigation from '../organisms/Navigation';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import { useNavigate } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';

const Component = () => {
  const { institution } = useSelector((state: RootState) => state.institution);
  const navigate = useNavigate();
  const canvasRef = React.useRef<HTMLCanvasElement | null>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [color, setColor] = React.useState('#ffffff');
  const [brushRadius, setBrushRadius] = React.useState(14);
  const [undo, setUndo] = useState<ImageData[]>([]);

  const setImages = () => {
    setTimeout(() => {
      const image = new Image();
      image.src = cat;
      image.onload = () => {
        const canvas = canvasRef.current;
        if (!canvas) return;
        const ctx = canvas.getContext('2d');
        if (!ctx) return;
        const imageWidth = image.width * 0.95;
        const imageHeight = image.height * 0.95;
        const x = (canvas.width - imageWidth) / 2;
        const y = (canvas.height - imageHeight) / 2;

        ctx.drawImage(image, x, y, imageWidth, imageHeight);
      };
    }, 500);
  };

  useEffect(setImages, []);

  const startDrawing = (e: React.MouseEvent<HTMLCanvasElement, MouseEvent>) => {
    setIsDrawing(true);
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.strokeStyle = color;
    ctx.lineWidth = brushRadius * 2;
    ctx.lineCap = 'round';
    ctx.beginPath();
    ctx.moveTo(e.nativeEvent.offsetX, e.nativeEvent.offsetY);

    const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    if (imageData) {
      setUndo([...undo, imageData]);
    }
  };

  const draw = (e: React.MouseEvent<HTMLCanvasElement, MouseEvent>) => {
    if (!isDrawing) return;
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.globalCompositeOperation = 'source-atop';

    ctx.lineTo(e.nativeEvent.offsetX, e.nativeEvent.offsetY);
    ctx.stroke();

    ctx.beginPath();
    ctx.lineCap = 'round';
    ctx.moveTo(e.nativeEvent.offsetX, e.nativeEvent.offsetY);
  };

  const endDrawing = () => {
    setIsDrawing(false);
  };

  const undoDraw = () => {
    if (undo.length === 0) return;

    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const lastState = undo[undo.length - 1];
    setUndo(undo.slice(0, -1));

    ctx.putImageData(lastState, 0, 0);
  };

  const handleExport = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const link = document.createElement('a');
    link.href = canvas.toDataURL('image/png');
    link.download = 'animal.png';
    link.click();
  };

  // ctrl + z
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.ctrlKey && e.key === 'z') {
        undoDraw();
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [undo]);

  const dataURItoBlob = (dataURI: string) => {
    const binStr = atob(dataURI.split(',')[1]);
    const len = binStr.length;
    const arr = new Uint8Array(len);

    for (let i = 0; i < len; i++) {
      arr[i] = binStr.charCodeAt(i);
    }

    return new Blob([arr]);
  };

  const handleSubmit = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const file = canvas.toDataURL('image/png');
    const blob = dataURItoBlob(file);
    const formData = new FormData();
    formData.append('files', blob);

    const instance = fetchInstanceWithToken();

    instance
      .post('/api/upload', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      })
      .then((res) => {
        const imageId = res.data[0].id;

        const body = {
          data: {
            avatar_icon: imageId,
            institution: institution.id,
          },
        };

        instance.post('/api/animals', body).then(() => {
          navigate('/');
        });
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden lg:block col-span-12 md:col-span-2">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 lg:col-span-8">
          <div className="bg-white rounded-xl shadow-md flex justify-center items-center px-2 py-4">
            <canvas
              className="lattice"
              ref={canvasRef}
              onMouseDown={startDrawing}
              onMouseUp={endDrawing}
              onMouseOut={endDrawing}
              onMouseMove={draw}
              width={800}
              height={600}
            />
          </div>
        </div>

        <div className="col-span-12 lg:col-span-2">
          <Card>
            <div className="flex flex-col gap-4 w-full py-2">
              <div className="flex gap-4">
                <p>Brush Radius</p>
                <input
                  type="number"
                  value={brushRadius}
                  min={0}
                  max={99}
                  onChange={(e) => setBrushRadius(Number(e.target.value))}
                />
              </div>
              <div className="flex gap-4">
                <p>Color</p>
                <input
                  type="color"
                  value={color}
                  onChange={(e) => setColor(e.target.value)}
                />
              </div>
              <Button text="ひとつ戻る" onClick={undoDraw} icon="mdi:undo" />
              <Button
                text="画像保存"
                onClick={handleExport}
                icon="mdi:download"
              />
              <hr className="my-2" />
              <Button
                text="登録"
                onClick={handleSubmit}
                icon="mdi:upload"
                highlight
              />
            </div>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
