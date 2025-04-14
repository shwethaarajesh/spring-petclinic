FROM openjdk:17-jdk
COPY target/spring-petclinic-*.jar /app.jar
EXPOSE 8080
CMD ["java", "-jar", "/app.jar"]