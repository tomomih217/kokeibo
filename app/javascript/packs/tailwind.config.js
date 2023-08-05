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
        'submenu': '#FFFEF3',
        info: colors.cyan,
        success: colors.emerald,
        warning: colors.orange,
        danger: colors.red,
      },
    },
  },
}
