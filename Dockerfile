FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8383
ADD target/*.jar app.jar
ENTRYPOINT [ "java","-jar", "app.jar" ]