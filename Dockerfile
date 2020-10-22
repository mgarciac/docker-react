FROM node:alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# /app/build: folder with build files

FROM nginx

# copy build folder to the new container
COPY --from=builder /app/build /usr/share/nginx/html



# In the next lecture, we will be creating a multi-step build in our production Dockerfile. AWS currently will fail if you attempt to use a named builder as shown.
# To remedy this, we should create an unnamed builder like so:

# Instead of this:

# FROM node:alpine as builder
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build
 
# FROM nginx
# COPY --from=builder /app/build /usr/share/nginx/html

# Do this:

# FROM node:alpine
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build
 
# FROM nginx
# COPY --from=0 /app/build /usr/share/nginx/html