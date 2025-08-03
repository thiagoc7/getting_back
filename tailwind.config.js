import { join } from "path"
import { skeleton } from '@skeletonlabs/tw-plugin'
import { daisyui } from 'daisyui'

/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class',
  content: [
    './src/**/*.{html,js,svelte,ts}',
    join(require('path').dirname(require.resolve('@skeletonlabs/skeleton')), '../skeleton/**/*.{html,js,svelte,ts}'),
    './app/**/*.{erb,haml,html,slim}',
    './lib/**/*.rb',
    './config/initializers/simple_form_tailwind.rb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    skeleton({
      themes: {
        preset: [
          { name: 'skeleton', enhancements: true },
        ],
      },
    }),
    daisyui
  ],
  daisyui: {
    themes: ["light", "dark", "cupcake", "bumblebee", "emerald", "corporate", "synthwave", "retro", "cyberpunk", "valentine", "halloween", "garden", "forest", "aqua", "lofi", "pastel", "fantasy", "wireframe", "black", "luxury", "dracula", "cmyk", "autumn", "business", "acid", "lemonade", "night", "coffee", "winter"],
  },
} 