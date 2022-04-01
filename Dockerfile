FROM openjdk:8-jdk-alpine

RUN mvn clean package -Dmaven.test.skip=true

ARG JAR_FILE=target/SpringRest-0.0.1-SNAPSHOT.jar

WORKDIR /opt/app

COPY ${JAR_FILE} app.jar

EXPOSE 8081

ENTRYPOINT ["java","-jar","app.jar"]