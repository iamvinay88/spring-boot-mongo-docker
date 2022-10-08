FROM maven:3.5-jdk-8 as outputjar
WORKDIR /app01
COPY . .
RUN mvn clean package


FROM openjdk:8-alpine
# Required for starting application up.
RUN apk update && apk add /bin/sh

RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app

COPY --from=outputjar /app01/target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

WORKDIR $PROJECT_HOME
EXPOSE 8080
CMD ["java" ,"-jar","./spring-boot-mongo.jar"]
