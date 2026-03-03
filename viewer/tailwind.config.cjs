/** @type {import('tailwindcss').Config} */
const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: ['./src/**/*.js', './src/templates/**/*.html'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [require('@tailwindcss/typography'), require('daisyui')],
  daisyui: {
    themes: [
      {
        square: {
          primary: '#284B63',
          'primary-content': '#F4F9E9',

          secondary: '#153243',
          'secondary-content': '#F4F9E9',

          accent: '#B4B8AB',
          'accent-content': '#153243',

          neutral: '#153243',
          'neutral-content': '#F4F9E9',

          'base-100': '#F4F9E9',
          'base-200': '#EEF0EB',
          'base-300': '#B4B8AB',
          'base-content': '#153243',

          info: '#284B63',
          success: '#284B63',
          warning: '#B4B8AB',
          error: '#B00020',
        },
      },
    ],
  },
};

