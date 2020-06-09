FROM tarampampam/node:lts-alpine

RUN apk add -q --no-cache --virtual .gyp python make g++ \
    && npm install node-pre-gyp -g

COPY package.json .
COPY yarn.lock .

RUN yarn install --production --prefer-offline

FROM node:lts-alpine
COPY --from=0 node_modules node_modules
