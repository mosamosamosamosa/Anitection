import React, { useEffect, useState } from 'react';
// import CanvasDraw from 'react-canvas-draw';
import cat from '../../assets/cat.png';
import Card from '../templates/Card';
import Layout from '../templates/Layout';
// import Button from '../atoms/Button';
import Navigation from '../organisms/Navigation';

const Component = () => {
  const canvasRef = React.useRef<HTMLCanvasElement | null>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [color, setColor] = React.useState('#ffffff');
  const [brushRadius, setBrushRadius] = React.useState(14);

  useEffect(() => {
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
  }, []);

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
              ref={canvasRef}
              onMouseDown={startDrawing}
              onMouseUp={endDrawing}
              onMouseOut={endDrawing}
              onMouseMove={draw}
              width={800}
              height={600}
              style={{ border: '1px solid black' }}
            />
          </div>
        </div>

        <div className="col-span-12 lg:col-span-2">
          <Card>
            <div className="flex flex-col gap-4 w-full">
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
              {/* <Button onClick={handleUndo} icon="mdi:undo" />
              <Button onClick={handleClear} icon="mdi:delete" />
              <Button onClick={handleExport} icon="mdi:download" highlight /> */}
            </div>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
