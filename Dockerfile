FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG EXTRACTED=/target/extracted
COPY ${EXTRACTED}/dependencies/ ./
COPY ${EXTRACTED}/spring-boot-loader/ ./
COPY ${EXTRACTED}/snapshot-dependencies/ ./
COPY ${EXTRACTED}/application/ ./
EXPOSE 8080:8080
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher"]