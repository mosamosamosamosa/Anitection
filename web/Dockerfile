FROM node:18.18.2-alpine AS builder

WORKDIR /usr/local/app

COPY . .

RUN yarn --frozen-lockfile && \
    REACT_APP_API_URL=https://anitection-api.yumekiti.net yarn build

FROM nginx:1.21.1-alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /usr/local/app/build /usr/share/nginx/html

CMD [ "nginx", "-g", "daemon off;" ]