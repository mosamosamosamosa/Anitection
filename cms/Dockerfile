FROM node:18.18.2-alpine

ARG APP_KEYS
ARG API_KEYS
ARG ADMIN_JWR_SECRET
ARG TRANSFER_TOKEN_SALT
ARG JWT_SECRET

RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev

WORKDIR /app

COPY . .

RUN yarn && yarn build

EXPOSE 1337

CMD ["yarn", "start"]