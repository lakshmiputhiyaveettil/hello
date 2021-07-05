FROM node:lts-alpine3.13 as builder
WORKDIR /app
COPY . /app

# install dependecies
RUN npm install

# build the apllication in prod mode
RUN npm run build

FROM nginx:alpine
EXPOSE 3000
COPY nginx.conf  /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/ /var/www/html/
CMD ["/bin/sh", "-c", "nginx -g \"daemon off;\""]