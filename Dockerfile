FROM node:lts-alpine as base

# install simple http server for serving static content
RUN npm install -g http-server

# make the 'app' folder the current working directory
WORKDIR /app

FROM base as build
# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# build app for production with minification
RUN npm run build
FROM base as production
COPY --from=build /app/dist /app
EXPOSE 8080
CMD [ "http-server"]