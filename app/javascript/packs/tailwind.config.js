const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/views/**/*.html.erb',
    './app/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/components/**/*.js',
    './node_modules/tailwindcss/color.js',
  ],
  darkMode: false, // or 'media' or 'class'
  variants: {
    extend: {},
  },
  plugins: [],
  theme: {
    fontFamily: {
      body: [
        'Courier',
        'Verdana',
        'Arial',
        'ヒラギノ角ゴシック',
        'YuGothic',
        "Yu Gothic",
        "Hiragino Sans",
        'sans-serif',
      ]
    },
    extend: {
      colors: {
        'amber-dark': '#5C5446',
        'amber-light': '#FFFBE3',
        'amber-card': '#FFF6C6',
        'amber-vivid': '#FE6B01',
        'submenu': '#FFFEF3',
        success: {
          100: '#d1fae5',
          500: '#10b981',
          700: '#047857',
        },
        danger: {
          100: '#fee2e2',
          500: '#ef4444',
          700: '#b91c1c',
        },
        warning: {
          100: '#ffedd5',
          500: '#f97316',
          700: '#c2410c',
        },
        info: {
          100: '#cffafe',
          500: '#06b6d4',
          700: '#0e7490',
        }
      }
    },
  },
}
