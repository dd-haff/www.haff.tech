#!/bin/bash
# Build script for Vercel (or local production build)

git submodule update --init --recursive
npm install
npm run build:css
hugo --minify
