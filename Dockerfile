
FROM maven:3.5-jdk-8 as build


WORKDIR /app


COPY pom.xml .

COPY src ./src

RUN mvn clean package -DskipTests


FROM openjdk:8-jre


WORKDIR /app


COPY --from=build /app/target/sqlitedb-1.0-SNAPSHOT.jar app.jar
COPY user.db /app/user.db


EXPOSE 8080


ENTRYPOINT ["java", "-jar", "app.jar"]
