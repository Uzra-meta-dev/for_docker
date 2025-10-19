FROM alpine:3

RUN apk add git openjdk17

RUN git clone https://github.com/dmdev2020/spring-starter.git

WORKDIR spring-starter

RUN git switch lesson-125

RUN ./gradlew bootJar

RUN cp build/libs/spring-starter-*.jar ./service.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "service.jar"]

