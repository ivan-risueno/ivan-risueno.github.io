FROM node:22 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:22 AS production

WORKDIR /app

RUN npm install -g http-server

COPY --from=build /app/dist ./dist

EXPOSE 4321

CMD ["http-server", "dist", "-p", "4321"]
