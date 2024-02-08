import React, { useEffect, useRef, useState } from 'react';
import Card from '../templates/Card';
import Layout from '../templates/Layout';
import Button from '../atoms/Button';
import Navigation from '../organisms/Navigation';
import { fetchInstanceWithToken } from '../../utils/fetchInstance';
import { useNavigate, useParams } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';

import { getAnimalImg } from '../../utils/img';
import useSWR from 'swr';

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
  const [loading, setLoading] = useState(false);

  const [isHead, setIsHead] = useState(true);
  const [isBody, setIsBody] = useState(false);
  const [isSitting, setIsSitting] = useState(false);
  const [isTail, setIsTail] = useState(false);
  const [isPreview, setIsPreview] = useState(false);

  const [animal, setAnimal] = useState<any>({});

  const [pedigree, setPedigree] = useState('ネコ');
  const [pattern, setPattern] = useState('ミケ');

  const { data: patterns } = useSWR<any>(
    '/api/patterns',
    fetchInstanceWithToken(),
  );

  const { data: pedigrees } = useSWR<any>(
    '/api/pedigrees',
    fetchInstanceWithToken(),
  );

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

    ctx.shadowOffsetY = 0;
    ctx.shadowBlur = 0;

    ctx.globalCompositeOperation = 'source-over';

    drawImage(image, canvas, ctx);
  }, [image, canvasRef.current]);

  useEffect(() => {
    const image = new Image();
    image.crossOrigin = 'Anonymous';

    if (animal.attributes) {
      if (isHead && animal.attributes.avatar_head.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_head.data.attributes.url}`;
      else if (isHead && !animal.attributes.avatar_head.data)
        image.src = getAnimalImg(pedigree, pattern).head;

      if (isBody && animal.attributes.avatar_body.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_body.data.attributes.url}`;
      else if (isBody && !animal.attributes.avatar_body.data)
        image.src = getAnimalImg(pedigree, pattern).body;

      if (isSitting && animal.attributes.avatar_sitting.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_sitting.data.attributes.url}`;
      else if (isSitting && !animal.attributes.avatar_sitting.data)
        image.src = getAnimalImg(pedigree, pattern).sitting;

      if (isTail && animal.attributes.avatar_tail.data)
        image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_tail.data.attributes.url}`;
      else if (isTail && !animal.attributes.avatar_tail.data)
        image.src = getAnimalImg(pedigree, pattern).tail;
    } else {
      if (isHead) image.src = getAnimalImg(pedigree, pattern).head;
      if (isBody) image.src = getAnimalImg(pedigree, pattern).body;
      if (isSitting) image.src = getAnimalImg(pedigree, pattern).sitting;
      if (isTail) image.src = getAnimalImg(pedigree, pattern).tail;
    }

    setTimeout(() => {
      setImage(image);
    }, 500);
  }, [isHead, isBody, isSitting, isTail, animal, pedigree, pattern]);

  // 影をつける
  const handleShadow = () => {
    if (isPreview) return;
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.globalCompositeOperation = 'source-over';

    // 一度状態を保存し保存した状態を貼り付ける
    ctx.save();

    ctx.shadowColor = 'rgba(0, 0, 0, 0.20)';
    ctx.shadowOffsetY = 12;
    ctx.shadowBlur = 10;

    ctx.drawImage(canvas, 0, 0);
    ctx.restore();
  };

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

    const head_image = new Image();
    head_image.crossOrigin = 'Anonymous';
    if (!animal.attributes.avatar_head.data) alert('頭を登録してください');
    head_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_head.data.attributes.url}`;

    const body_image = new Image();
    const sitting_image = new Image();
    let sitting = false;

    if (animal.attributes.avatar_body.data) {
      body_image.crossOrigin = 'Anonymous';
      body_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_body.data.attributes.url}`;
    }

    if (animal.attributes.avatar_sitting.data) {
      sitting_image.crossOrigin = 'Anonymous';
      sitting_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_sitting.data.attributes.url}`;
      sitting = true;
    }

    const tail_image = new Image();
    tail_image.crossOrigin = 'Anonymous';
    if (!animal.attributes.avatar_tail.data) alert('尻尾を登録してください');
    tail_image.src = `${process.env.REACT_APP_API_URL}${animal.attributes.avatar_tail.data.attributes.url}`;

    setTimeout(() => {
      if (!sitting) {
        ctx.drawImage(tail_image, 280, 30);
        ctx.drawImage(body_image, 0, 50);
        ctx.drawImage(head_image, -110, -140);
      } else {
        ctx.drawImage(tail_image, 190, 100);
        ctx.drawImage(sitting_image, -20, 60);
        ctx.drawImage(head_image, -30, -140);
      }
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

    ctx.shadowOffsetY = 0;
    ctx.shadowBlur = 0;

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

  const handleDelete = () => {
    setLoading(true);
    const canvas = canvasRef.current;
    if (!canvas) return;

    const file = canvas.toDataURL('image/png');
    const blob = dataURItoBlob(file);
    const formData = new FormData();
    formData.append('files', blob, 'animal.png');

    const instance = fetchInstanceWithToken();

    if (id) {
      let data: any;

      if (isHead) data = { avatar_head: null };
      if (isBody) data = { avatar_body: null };
      if (isSitting) data = { avatar_sitting: null };
      if (isTail) data = { avatar_tail: null };
      if (isPreview) data = { avatar_icon: null };

      const body = {
        data: data,
      };

      instance.put(`/api/animals/${id}`, body).then(() => {
        instance.get(`/api/animals/${id}`).then((res) => {
          setAnimal(res.data.data);
          setLoading(false);
          if (isPreview) navigate(`/${id}`);
        });
      });

      return;
    }
  };

  const handleSubmit = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const file = canvas.toDataURL('image/png');
    const blob = dataURItoBlob(file);
    const formData = new FormData();
    formData.append('files', blob, 'animal.png');

    const instance = fetchInstanceWithToken();

    setLoading(true);
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
              setLoading(false);
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
            setLoading(false);
            navigate(`/register/${res.data.data.id}`);
          });
        })
        .catch((err) => {
          console.log(err);
        });
    }
  };

  if (!patterns) return <p>Loading...</p>;
  if (!pedigrees) return <p>Loading...</p>;

  const animal_patterns = patterns.data.data;
  const animal_pedigrees = pedigrees.data.data;

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-4">
        {/* なび */}
        <div className="hidden lg:block col-span-12 md:col-span-2">
          <Navigation />
        </div>

        {/* 動物 */}
        <div className="col-span-12 lg:col-span-8">
          <div className="bg-neutral-100 rounded-xl shadow-md flex justify-center items-center px-2 py-4 relative">
            {/* 左上にselect */}
            <div className="absolute top-3 left-3 z-10 bg-white p-2 rounded-md shadow-md border border-neutral-200">
              {pedigree !== 'ネコ' && (
                <select
                  value={pedigree}
                  onChange={(e) => setPedigree(e.target.value)}
                >
                  {animal_pedigrees &&
                    animal_pedigrees.map((pedigree: any) => (
                      <option
                        key={pedigree.id}
                        value={pedigree.attributes.name}
                        selected={pedigree.attributes.name === pedigree}
                      >
                        {pedigree.attributes.name}
                      </option>
                    ))}
                </select>
              )}
              {pedigree === 'ネコ' && (
                <select
                  value={pattern}
                  onChange={(e) => setPattern(e.target.value)}
                >
                  {animal_patterns &&
                    animal_patterns.map((pattern: any) => (
                      <option
                        key={pattern.id}
                        value={pattern.attributes.name}
                        selected={pattern.attributes.name === pattern}
                      >
                        {pattern.attributes.name}
                      </option>
                    ))}
                </select>
              )}
            </div>
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
            {/* loading */}
            {loading && (
              <div className="absolute z-10 bg-white opacity-50 w-full h-full flex justify-center items-center">
                <p className="text-2xl">Loading...</p>
              </div>
            )}
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
              <Button text="削除" onClick={handleDelete} icon="mdi:delete" />
              <hr className="my-2" />
              <Button
                text="犬"
                onClick={() => setPedigree('いぬ')}
                icon="mdi:dog"
                highlight={pedigree !== 'ネコ'}
              />
              <Button
                text="猫"
                onClick={() => setPedigree('ネコ')}
                icon="mdi:cat"
                highlight={pedigree === 'ネコ'}
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
                onClick={() => {
                  new Promise((resolve: any) => {
                    handleShadow();
                    resolve();
                  }).then(() => {
                    handleSubmit();
                  });
                }}
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
