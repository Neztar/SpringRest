FROM maven:3.8.4-jdk-11-slim

# Build dependency offline to streamline build
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src src
RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:8-jdk
COPY --from=0 /target/SpringRest-0.0.1-SNAPSHOT.jar /app/target/SpringRest-0.0.1-SNAPSHOT.jar

EXPOSE 8081
ENTRYPOINT [ "java", "-jar", "/app/target/SpringRest-0.0.1-SNAPSHOT.jar", "--server.port=8081" ]