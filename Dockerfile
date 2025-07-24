# start from a Maven image with Java 11
FROM maven:3.9.9-eclipse-temurin-21 AS builder

# set working directory
WORKDIR /workspace

# copy project files
COPY pom.xml .
COPY src src

# build plugin, cache .m2 to reuse Maven artifacts
RUN mvn --batch-mode clean install

# use Jenkins base image to host the plugin
FROM jenkins/jenkins:lts-jdk17

# skip setup UI
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# copy the built .hpi into Jenkins plugin directory
COPY --from=builder /workspace/target/ansicolor-1.0.7-SNAPSHOT.hpi \
    /usr/share/jenkins/ref/plugins/ansicolor.hpi
