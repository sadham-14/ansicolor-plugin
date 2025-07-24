# ---- Stage 1: Build the plugin ----
FROM maven:3.9.6-eclipse-temurin-11 AS builder

WORKDIR /plugin

# Copy the source code
COPY . .

# Build plugin (skip tests if needed)
RUN mvn clean package -DskipTests

# ---- Stage 2: Package with Jenkins ----
FROM jenkins/jenkins:2.387.2-jdk11

USER root

# Create plugin directory if not exists
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the built plugin
COPY --from=builder /plugin/target/*.hpi /usr/share/jenkins/ref/plugins/bmc-cfa.hpi

# Give ownership to jenkins user
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins

USER jenkins
