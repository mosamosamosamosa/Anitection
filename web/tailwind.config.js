/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        background: '#FFF8E0',
        headline: '#272343',
        paragraph: '#2d334a',
        button: '#ffd803',
        'button-text': '#444444',
        stroke: '#C3EB89',
        main: '#FFFFFE',
        highlight: '#C3EB89',
        secondary: '#e3f6f5',
        tertiary: '#bae8e8',
      },
      animation: {
        'slide-in-left':
          'slide-in-left 0.2s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both',
      },
      keyframes: {
        'slide-in-left': {
          '0%': {
            transform: 'translateX(-1000px)',
            opacity: '0',
          },
          to: {
            transform: 'translateX(0)',
            opacity: '1',
          },
        },
      },
    },
  },
  plugins: [
    function ({ addUtilities }) {
      const newUtilities = {
        '.stroked': {
          'text-shadow':
            '-1px -1px 0 #fff, 1px -1px 0 #fff, -1px 1px 0 #fff, 1px 1px 0 #fff',
        },
      };

      addUtilities(newUtilities);
    },
  ],
};
