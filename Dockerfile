FROM alpine:3.7

RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN git clone https://github.com/spring-projects/spring-boot.git
RUN apk add maven
RUN cd  ./spring-boot/spring-boot-samples/spring-boot-sample-actuator-ui && \
    mvn package
RUN cp ./spring-boot/spring-boot-samples/spring-boot-sample-actuator-ui/target/spring-boot-sample-actuator-ui-2.2.0.BUILD-SNAPSHOT.jar /tmp
RUN rm -r spring-boot
WORKDIR /tmp
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-boot-sample-actuator-ui-2.2.0.BUILD-SNAPSHOT.jar"]



