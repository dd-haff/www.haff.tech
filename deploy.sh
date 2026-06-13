#!/bin/bash
set -e

npm run build:css
npm run build
firebase deploy --only hosting
