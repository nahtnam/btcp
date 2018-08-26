FROM mhart/alpine-node:10
WORKDIR /usr/src
COPY package.json package-lock.json /usr/src/
RUN npm install
COPY . .
RUN npm run build -- --dest /public
