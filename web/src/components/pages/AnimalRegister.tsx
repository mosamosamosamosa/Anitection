import React, { useEffect } from 'react';
import CanvasDraw from 'react-canvas-draw';
import cat from '../../assets/cat.png';
import Card from '../templates/Card';
import Layout from '../templates/Layout';
import Button from '../atoms/Button';
import Navigation from '../organisms/Navigation';

const Component = () => {
  const canvasRef = React.useRef<CanvasDraw | null>(null);
  const [color, setColor] = React.useState('#000000');
  const [canvas, setCanvas] = React.useState<Element | null>(null);
  const [lazyRadius, setLazyRadius] = React.useState(16);
  const [brushRadius, setBrushRadius] = React.useState(24);

  const handleClear = () => {
    canvasRef.current?.clear();
  };

  const handleUndo = () => {
    canvasRef.current?.undo();
  };

  const handleExport = () => {
    if (canvas) {
      const canvasElement = canvas as HTMLCanvasElement;
      const image = canvasElement.toDataURL('image/png');
      const link = document.createElement('a');
      link.download = 'image.png';
      link.href = image;
      link.click();
    }
  };

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.ctrlKey && e.key === 'z') {
        handleUndo();
      }
    };

    window.addEventListener('keydown', handleKeyDown);

    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, []);

  useEffect(() => {
    setCanvas(document.querySelector('canvas:nth-child(2)'));

    if (canvas) {
      const canvasElement = document.querySelector(
        'canvas:nth-child(1)',
      ) as HTMLCanvasElement;
      const ctx = canvasElement.getContext('2d');
      if (!ctx) return;
      const image = new Image();
      image.src = cat;
      image.onload = () => {
        const imageWidth = image.width * 0.95;
        const imageHeight = image.height * 0.95;
        const x = (canvasElement.width - imageWidth) / 2;
        const y = (canvasElement.height - imageHeight) / 2;
        setTimeout(() => {
          ctx.globalAlpha = 0.8;
          ctx.drawImage(image, x, y, imageWidth, imageHeight);
        }, 500);
      };
    }
  }, [canvas]);

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
            <CanvasDraw
              brushColor={color}
              canvasWidth={800}
              canvasHeight={600}
              ref={canvasRef}
              brushRadius={brushRadius}
              lazyRadius={lazyRadius}
              gridColor="rgba(0,0,0,1)"
            />
          </div>
        </div>

        <div className="col-span-12 lg:col-span-2">
          <Card>
            <div className="flex flex-col gap-4 w-full">
              <div className="flex gap-4">
                <p>Lazy Radius</p>
                <input
                  type="number"
                  value={lazyRadius}
                  min={0}
                  max={99}
                  onChange={(e) => setLazyRadius(Number(e.target.value))}
                />
              </div>
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
              <Button onClick={handleUndo} icon="mdi:undo" />
              <Button onClick={handleClear} icon="mdi:delete" />
              <Button onClick={handleExport} icon="mdi:download" highlight />
            </div>
          </Card>
        </div>
      </div>
    </Layout>
  );
};

export default Component;
