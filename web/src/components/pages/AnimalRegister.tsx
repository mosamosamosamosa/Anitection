import React, { useEffect, useRef, useState } from 'react';
import head from '../../assets/animals/cat/head.png';
import body from '../../assets/animals/cat/body.png';
import sitting from '../../assets/animals/cat/sitting.png';
import tail from '../../assets/animals/cat/tail.png';
import Card from '../templates/Card';
import Layout from '../templates/Layout';
import Button from '../atoms/Button';
import Navigation from '../organisms/Navigation';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import { useNavigate, useParams } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';

const Component = () => {
  const { id } = useParams();
  const { institution } = useSelector((state: RootState) => state.institution);
  const navigate = useNavigate();
  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [color, setColor] = useState('#ffffff');
  const [brushRadius, setBrushRadius] = useState(24);
  const [undo, setUndo] = useState<ImageData[]>([]);
  const [image, setImage] = useState<HTMLImageElement>(new Image());

  const [isHead, setIsHead] = useState(true);
  const [isBody, setIsBody] = useState(false);
  const [isSitting, setIsSitting] = useState(false);
  const [isTail, setIsTail] = useState(false);
  const [isPreview, setIsPreview] = useState(false);

  const [animal, setAnimal] = useState<any>({});

  useEffect(() => {
    if (!id) return;
    const instance = fetchInstanceWithToken();
    instance.get(`/api/animals/${id}`).then((res) => {
      setAnimal(res.data.data);
    });
  }, [id]);

  const drawImage = (
    image: HTMLImageElement,
    canvas: HTMLCanvasElement,
    ctx: CanvasRenderingContext2D,
  ) => {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    const imageWidth = image.width * 1;
    const imageHeight = image.height * 1;
    const x = (canvas.width - imageWidth) / 2;
    const y = (canvas.height - imageHeight) / 2;

    ctx.drawImage(image, x, y, imageWidth, imageHeight);
  };

  useEffect(() => {
    if (!canvasRef.current) return;
    setIsDrawing(false);
    const canvas = canvasRef.current;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.globalCompositeOperation = 'source-over';

    ctx.shadowColor = 'rgba(0, 0, 0, 0.20)';
    ctx.shadowOffsetY = 12;
    ctx.shadowBlur = 10;

    drawImage(image, canvas, ctx);
  }, [image, canvasRef.current]);

  useEffect(() => {
    const image = new Image();
    image.crossOrigin = 'Anonymous';

    if (animal.attributes) {
      if (isHead && animal.attributes.avatar_head.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_head.data.attributes.url}`;
      else if (isHead && !animal.attributes.avatar_head.data) image.src = head;

      if (isBody && animal.attributes.avatar_body.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_body.data.attributes.url}`;
      else if (isBody && !animal.attributes.avatar_body.data) image.src = body;

      if (isSitting && animal.attributes.avatar_sitting.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_sitting.data.attributes.url}`;
      else if (isSitting && !animal.attributes.avatar_sitting.data)
        image.src = sitting;

      if (isTail && animal.attributes.avatar_tail.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_tail.data.attributes.url}`;
      else if (isTail && !animal.attributes.avatar_tail.data) image.src = tail;
    } else {
      if (isHead) image.src = head;
      if (isBody) image.src = body;
      if (isSitting) image.src = sitting;
      if (isTail) image.src = tail;
    }

    setTimeout(() => {
      setImage(image);
    }, 500);
  }, [isHead, isBody, isSitting, isTail, animal]);

  const handleReset = () => {
    setIsHead(false);
    setIsBody(false);
    setIsSitting(false);
    setIsTail(false);
    setIsPreview(false);
  };

  const handleHead = () => {
    handleReset();
    setIsHead(true);
  };

  const handleBody = () => {
    handleReset();
    setIsBody(true);
  };

  const handleSitting = () => {
    handleReset();
    setIsSitting(true);
  };

  const handleTail = () => {
    handleReset();
    setIsTail(true);
  };

  const handlePreview = () => {
    handleReset();
    setIsPreview(true);

    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.globalCompositeOperation = 'source-over';
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.globalCompositeOperation = 'source-over';
    const head_image = new Image();
    head_image.crossOrigin = 'Anonymous';
    if (!animal.attributes.avatar_head.data) alert('頭を登録してください');
    head_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_head.data.attributes.url}`;

    const body_image = new Image();
    body_image.crossOrigin = 'Anonymous';
    if (!animal.attributes.avatar_body.data) alert('体を登録してください');
    body_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_body.data.attributes.url}`;

    const tail_image = new Image();
    tail_image.crossOrigin = 'Anonymous';
    if (!animal.attributes.avatar_tail.data) alert('尻尾を登録してください');
    tail_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_tail.data.attributes.url}`;

    setTimeout(() => {
      ctx.drawImage(tail_image, 280, 20);
      ctx.drawImage(body_image, 0, 50);
      ctx.drawImage(head_image, -100, -100);
    }, 1000);
  };

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
    ctx.shadowOffsetY = 0;
    ctx.shadowBlur = 0;

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
    formData.append('files', blob, 'animal.png');

    const instance = fetchInstanceWithToken();

    if (id) {
      instance
        .post('/api/upload', formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        })
        .then((res) => {
          const imageId = res.data[0].id;
          let data: any;

          if (isHead) data = { avatar_head: imageId };
          if (isBody) data = { avatar_body: imageId };
          if (isSitting) data = { avatar_sitting: imageId };
          if (isTail) data = { avatar_tail: imageId };
          if (isPreview) data = { avatar_icon: imageId };

          const body = {
            data: data,
          };

          instance.put(`/api/animals/${id}`, body).then(() => {
            instance.get(`/api/animals/${id}`).then((res) => {
              setAnimal(res.data.data);
              if (isPreview) navigate(`/${id}`);
            });
          });
        });

      return;
    } else {
      instance
        .post('/api/upload', formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        })
        .then((res) => {
          const imageId = res.data[0].id;

          let data: any;
          if (isHead) data = { avatar_head: imageId };
          if (isBody) data = { avatar_body: imageId };
          if (isSitting) data = { avatar_sitting: imageId };
          if (isTail) data = { avatar_tail: imageId };

          const body = {
            data: {
              ...data,
              institution: institution.id,
            },
          };

          instance.post('/api/animals', body).then((res) => {
            navigate(`/register/${res.data.data.id}`);
          });
        })
        .catch((err) => {
          console.log(err);
        });
    }
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
          <div className="bg-neutral-100 rounded-xl shadow-md flex justify-center items-center px-2 py-4">
            <canvas
              id={isPreview ? 'preview' : 'canvas'}
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
                text="頭"
                onClick={handleHead}
                icon="mdi:cat"
                highlight={isHead}
              />
              <Button
                text="体"
                onClick={handleBody}
                icon="solar:body-line-duotone"
                highlight={isBody}
              />
              <Button
                text="座り"
                onClick={handleSitting}
                icon="game-icons:sitting-dog"
                highlight={isSitting}
              />
              <Button
                text="尻尾"
                onClick={handleTail}
                icon="game-icons:fox-tail"
                highlight={isTail}
              />
              <hr className="my-2" />
              <Button
                text="プレビュー"
                onClick={handlePreview}
                icon="mdi:eye"
                highlight={isPreview}
              />
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
