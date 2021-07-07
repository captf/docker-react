FROM node:alpine
# FROM node:alpine as builder - removed as AWS doesn't like named builders

WORKDIR '/app'
COPY package.json .
RUN npm install

COPY . .

RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html
# COPY --from=builder /app/build /usr/share/nginx/html when you can use named builders