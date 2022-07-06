# create a container that has all the files (build dir)
# we do not need other files in our prod env hence step2
FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# step2: create a new container with ngnix image
# copy over the build dir to this container
FROM nginx
COPY --from=builder /app/build /usr/share/ngnix/html