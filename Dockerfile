FROM node:18-alpine AS builder
    MAINTAINER Name <namesexistsinemails@gmail.com>

RUN mkdir /app && mkdir /app/data

COPY . /app

RUN cd /app && yarn install && yarn build



FROM node:18-alpine

RUN mkdir /app

COPY --from=builder /app/build /app/build
COPY --from=builder /app/package.json /app/yarn.lock /app/

RUN cd /app && yarn install --production && yarn cache clean

WORKDIR /app

CMD ["node", "build/index.js"]

EXPOSE 3000
