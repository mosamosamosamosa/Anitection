FROM node:18.18.2-alpine

RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev

WORKDIR /app

COPY . .

RUN yarn && yarn build

EXPOSE 1337

CMD ["yarn", "develop"]