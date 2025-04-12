# Sử dụng Node.js LTS version làm base image
FROM node:18-alpine

# Tạo thư mục làm việc
WORKDIR /app

# Copy package.json và package-lock.json
COPY package*.json ./

# Cài đặt dependencies
RUN npm install

# Copy toàn bộ source code
COPY . .

# Build ứng dụng
RUN npm run build

# Expose port
EXPOSE 3000

# Chạy ứng dụng
CMD ["npm", "start"] 