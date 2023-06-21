const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/packs/**.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
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
/*    colors: {
     white: colors.white,
      blue: colors.blue,
      green: colors.green,
      info: colors.cyan,
      success: colors.emerald,
      warning: colors.orange,
      danger: colors.red, 
    },*/
    extend: {
      colors: {
        'amber-dark': '#5C5446',
        'amber-light': '#FFFBE3',
        'amber-card': '#FFF6C6',
        'amber-vivid': '#FE6B01',
        info: colors.cyan,
        success: colors.emerald,
        warning: colors.orange,
        danger: colors.red,
      },
    },
  },
}
