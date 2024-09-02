# Step 1: Use an official Node image as the base image for building the app
FROM node:18 AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Step 4: Install the dependencies, including all dependencies (devDependencies included)
RUN npm install

# Step 5: Copy the rest of the application source code to the working directory
COPY . .

# Step 6: Build the application for production
RUN npm run build

# Step 7: Use an official Nginx image to serve the built app
FROM nginx:alpine

# Step 8: Copy the build output from the previous step to the Nginx HTML folder
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 8080 to allow traffic to the Nginx server
EXPOSE 8080

# Step 10: Update the Nginx configuration to listen on port 8080
RUN sed -i 's/    listen       80;/    listen       8080;/' /etc/nginx/conf.d/default.conf

# Step 11: Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
