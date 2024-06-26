FROM node:20 As development
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
FROM node:20 as production
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
COPY --from=development /usr/src/app/dist ./dist
CMD ["node", "dist/main"]