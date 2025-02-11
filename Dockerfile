# Step 1: Use the official Node.js image as the base image
FROM node:18

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json files to the container
COPY package*.json ./

# Step 4: Install the project dependencies
RUN npm install

# Step 5: Copy the rest of the application source code to the working directory
COPY . .

# Step 6: Expose the port your application runs on
EXPOSE 8080

# Step 7: Define the command to run your application
CMD ["npm", "start"]
