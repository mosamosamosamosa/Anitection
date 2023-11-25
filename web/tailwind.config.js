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
    },
  },
  plugins: [
    function ({ addUtilities }) {
      const newUtilities = {
        '.stroked': {
          'text-shadow':
            '-0.5px -0.5px 0 #fff, 0.5px -0.5px 0 #fff, -0.5px 0.5px 0 #fff, 0.5px 0.5px 0 #fff',
        },
      };

      addUtilities(newUtilities);
    },
  ],
};
