import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
    root: "src-react",
    publicDir: "../public",
    build: {
        outDir: "../target/dist"
    },
    plugins: [react()],
})
