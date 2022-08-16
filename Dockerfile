FROM node:lts-alpine3.15 as build
WORKDIR /app
COPY package.json .
COPY src/ /app/src
COPY public/ /app/public
RUN yarn install
RUN yarn build

FROM nginx:stable-alpine
COPY --from=build /app/build/ /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]