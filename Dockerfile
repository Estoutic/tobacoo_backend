FROM maven:3.9.2-amazoncorretto-17-debian-bullseye AS build

COPY pom.xml /tobacoo_backend/
COPY src /tobacoo_backend/src

RUN mvn -f /tobacoo_backend/pom.xml clean package

# Run stage
FROM openjdk:17-jdk-alpine as deploy
COPY --from=build /tobacoo_backend/target/tobacoo_backend*.jar /tobacoo_backend/tobacoo_backend.jar
ENTRYPOINT ["java","-jar","/tobacoo_backend/tobacoo_backend.jar"]