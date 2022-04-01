FROM maven:3.8.1-openjdk-17-slim

WORKDIR /build

# Build dependency offline to streamline build
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src src
RUN mvn package -Dmaven.test.skip=true

FROM openjdk:11-jdk
COPY --from=0 /build/target/SpringRest-0.0.1-SNAPSHOT /app/target/SpringRest-0.0.1-SNAPSHOT

EXPOSE 8081
ENTRYPOINT [ "java", "-jar", "/app/target/SpringRest-0.0.1-SNAPSHOT", "--server.port=8081" ]