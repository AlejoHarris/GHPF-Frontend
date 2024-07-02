# Build image
FROM node:20-alpine3.20 AS build_image

WORKDIR /app

COPY package.json /app
RUN npm install
COPY src /app/src
COPY public /app/public


RUN npm run build

# Final image
FROM nginx:latest

COPY nginx.conf /etc/nginx/http.d/default.conf

COPY --from=build_image /app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
