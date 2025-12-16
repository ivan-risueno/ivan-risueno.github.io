FROM node:22 AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:22 AS production

WORKDIR /app

COPY --from=build /app ./

RUN npm ci --only=production

EXPOSE 4321

CMD ["npm", "run", "preview", "--", "--host"]
