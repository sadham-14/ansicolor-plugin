FROM maven:3.9.6-eclipse-temurin-11

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /plugin

COPY . .

# Make sure all plugins can be downloaded, including hpi plugin
RUN mvn -ntp -B clean install
