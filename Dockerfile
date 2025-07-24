# ---- Stage 1: Build the plugin ----
FROM maven:3.9.6-eclipse-temurin-11 AS builder

# Install git (required by some Jenkins plugin builds)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /plugin

# Copy the full project
COPY . .

# Add Jenkins Plugin Parent POMs (required for 'hpi' packaging to work)
RUN mvn -ntp -B org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
    -Dartifact=org.jenkins-ci.plugins:plugin:4.64 \
    -Dtransitive=false

# Now build
RUN mvn clean package -DskipTests
