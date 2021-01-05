FROM node AS dependencies
COPY ./package.json /root/.
WORKDIR /root
RUN npm i

FROM node AS builder
COPY ./ /root/.
COPY --from=dependencies /root/node_modules /root/node_modules
WORKDIR /root
RUN npm run-script build
RUN ls

FROM nginx AS webserver
COPY --from=builder /root/out /usr/share/nginx/html