#!/bin/bash
#remove type:module from package.json
pnpm create vite container
cd container
pnpm add @mui/material @emotion/react @emotion/styled
pnpm add @fontsource/roboto
pnpm add @mui/icons-material
pnpm add sass
pnpm add @mui/x-charts
pnpm add ts-node
pnpm add csv-parse
pnpm add ag-grid-react

pnpm install
pnpm run dev
