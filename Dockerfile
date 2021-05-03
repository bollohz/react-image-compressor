FROM node:12.18 as builder

RUN mkdir -p /usr/src/client
WORKDIR /usr/src/client
ENV PATH /usr/src/client/node_modules/.bin:$PATH
COPY .  .

RUN npm install
RUN npm run build

CMD ["npm", "start"]
