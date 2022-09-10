FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar --spring.config.location=file:///application.properties"]