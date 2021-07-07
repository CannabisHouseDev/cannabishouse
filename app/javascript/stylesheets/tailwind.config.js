// tailwind.config.js
const { colors: defaultColors, colors } = require('tailwindcss/defaultTheme');

// tailwind.config.js
module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    container: {
      center: true,
      padding: {
        DEFAULT: '1rem',
        sm: '2rem',
        lg: '4rem',
        xl: '5rem',
      },
    },
    extend: {},
    colors: {
      ...colors,
      primary: {
        50: '#F7FEE7',
        100: '#ECFCCB',
        200: '#D9F99D',
        300: '#BEF264',
        400: '#A3E635',
        500: '#84CC16',
        600: '#65A30D',
        DEFAULT: '#65A30D',
        700: '#4D7C0F',
        800: '#3F6212',
        900: '#365314',
      },
    },
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'active'],
    justifyContent: ['hover'],
    translate: ['responsive', 'hover', 'group-hover', 'focus'],
    transform: ['group-hover'],
    display: ['responsive'],
  },

  plugins: [require('@tailwindcss/forms'), require('@tailwindcss/typography'), require('@tailwindcss/aspect-ratio')],
};
