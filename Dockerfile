FROM mhart/alpine-node AS build
WORKDIR /build
COPY package.json package-lock.json /build/
ADD . /build/
RUN npm ci --prod

FROM mhart/alpine-node:base
WORKDIR /app
COPY --from=build /build .
CMD ["node", "./node_modules/.bin/json-server", "db.json", "-q", "--ro", "--port", "3000", "--host", "0.0.0.0"]
