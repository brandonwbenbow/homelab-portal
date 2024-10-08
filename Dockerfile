# Fetching the latest node image on apline linux
FROM node:22-alpine AS builder

# Declaring env
# ENV NODE_ENV production

# Setting up the work directory
WORKDIR /app

# Installing dependencies
COPY ./package.json ./
RUN yarn

# Copying all the files in our project
COPY . .
RUN ls

# Building our application
RUN yarn run build

# Fetching the latest nginx image
FROM nginx

# Copying built assets from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Copying our nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf