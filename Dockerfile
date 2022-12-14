FROM gradle:7.2.0-jdk17 AS BUILD

COPY . /src
WORKDIR /src
RUN gradle --no-daemon shadowJar

FROM openjdk:17-alpine

COPY --from=BUILD /src/build/libs/application.jar /bin/runner/run.jar
WORKDIR /bin/runner

CMD ["java","-jar","run.jar"]