import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/projeto-lncc-sdumont/',
  plugins: [react()],
  build: {
    outDir: 'docs',
  },
  server: {
    host: '0.0.0.0', 
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://backend:8000', 
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''), 
      },
    },
  },
})
