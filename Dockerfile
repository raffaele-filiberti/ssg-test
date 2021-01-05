FROM node AS builder
COPY ./ /root/.
WORKDIR /root
RUN npm i && \
    npm run-script build

FROM nginx AS webserver
COPY --from=builder /root/out /usr/share/nginx/html