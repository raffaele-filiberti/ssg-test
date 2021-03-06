FROM node:12-slim AS dependencies
COPY ./package.json ./yarn.lock /root/
WORKDIR /root
RUN yarn

FROM node:12-slim AS builder
COPY ./ /root/.
COPY --from=dependencies /root/node_modules /root/node_modules
WORKDIR /root
RUN yarn build

CMD ["yarn", "start"]

# FROM nginx AS webserver
# COPY --from=builder /root/out /usr/share/nginx/html