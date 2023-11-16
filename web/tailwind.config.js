/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        background: '#fffffe',
        headline: '#272343',
        paragraph: '#2d334a',
        button: '#ffd803',
        'button-text': '#272343',
        stroke: '#C3EB89',
        main: '#fffffe',
        highlight: '#ffd803',
        secondary: '#e3f6f5',
        tertiary: '#bae8e8',
      },
    },
  },
  plugins: [],
};
