const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/views/**/*.html.erb',
    './app/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/components/**/*.js',
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
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      success: colors.emerald,
      info: colors.cyan,
      warning: colors.orange,
      danger: colors.red,
      white: colors.white,
      gray: colors.gray,
      blue: colors.blue,
      green: colors.green,
      yellow: colors.yellow,
      red: colors.red
    },
    extend: {
      colors: {
        'amber-dark': '#5C5446',
        'amber-light': '#FFFBE3',
        'amber-card': '#FFF6C6',
        'amber-vivid': '#FE6B01',
        'submenu': '#FFFEF3',
      }
    },
  },
}
