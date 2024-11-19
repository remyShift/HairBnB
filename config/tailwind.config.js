const defaultTheme = require('tailwindcss/defaultTheme')


module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'primary': '#FF385C',
        'heavyprimary' : '#B80022',
        'lightprimary' : '#FF99AC',

      },
      fontFamily: {
        'kaushan': ['Kaushan Script', 'cursive'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
