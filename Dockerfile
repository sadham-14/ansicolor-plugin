# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy the source code
COPY . .

# Build the plugin
RUN mvn clean package -DskipTests

# Stage 2: Output plugin artifact
FROM alpine:3.20

COPY --from=build /app/target/*.hpi /ansicolor.hpi

CMD ["ls", "-lh", "/ansicolor.hpi"]
