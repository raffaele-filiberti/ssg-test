FROM node AS dependencies
COPY ./package.json /root/.
WORKDIR /root
RUN yarn

FROM node AS builder
COPY ./ /root/.
COPY --from=dependencies /root/node_modules /root/node_modules
WORKDIR /root
RUN yarn build

FROM nginx AS webserver
COPY --from=builder /root/out /usr/share/nginx/html