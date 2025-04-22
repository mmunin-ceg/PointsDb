# Build stage
FROM node:18 as build

WORKDIR /app

# Copy package manifests
COPY package*.json ./

# Install dependencies with Rollup
RUN npm install
RUN npm install @rollup/rollup-linux-x64-gnu

# Copy source files
COPY . .

# Build the application
RUN npm run build

# Production stage with Nginx
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
