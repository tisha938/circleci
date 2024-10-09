
FROM node:14 AS build


WORKDIR /app


COPY package*.json ./


RUN npm install

# Copy the rest of the application code.
COPY . .

# Build the React app.
RUN npm run build

# Use a lightweight web server to serve the build.
FROM nginx:alpine

# Copy the build files to the nginx server.
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80.
EXPOSE 80

# Start nginx server.
CMD ["nginx", "-g", "daemon off;"]
