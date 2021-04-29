FROM node:12.18 as builder

RUN mkdir -p /usr/src/client
WORKDIR /usr/src/client
ENV PATH /usr/src/client/node_modules/.bin:$PATH
COPY .  .

RUN npm install
RUN npm run build

CMD ["npm", "start"]

#FROM nginx:1.16.0-alpine as production
#
#COPY --from=builder /usr/src/client/build /usr/share/nginx/html
#RUN rm /etc/nginx/conf.d/default.conf
#
#COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
#COPY ./docker/nginx/conf.d /etc/nginx/conf.d
#
#EXPOSE 80 8080
#
#CMD ["nginx", "-g", "daemon off;"]
