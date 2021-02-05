# Process 1/2 - build project
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Process 2/2 - deploy build to nginx image
FROM nginx
# Expose port 80 for deploy to AWS EB
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html