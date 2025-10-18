#my first image
ARG alpine_version=3
FROM alpine:${alpine_version} AS base
ARG buildno=1

WORKDIR /
WORKDIR app
WORKDIR build

RUN touch test2.txt && echo "Hello world" >> test2.txt

RUN cd .. \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.48/bin/apache-tomcat-10.1.48.tar.gz \
    && tar -xvzf apache-tomcat-10.1.48.tar.gz \
    && rm apache-tomcat-10.1.48.tar.gz

COPY .idea idea-new
COPY .idea/*.xml idea-new-xml/
COPY tomcat.tar.gz /app
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.48/bin/apache-tomcat-10.1.48.tar.gz tomcat-add.tar.gz

FROM alpine:${alpine_version}
RUN apk add openjdk17
COPY --from=base /app/apache-tomcat-10.1.48 /app/apache-tomcat-10.1.48


EXPOSE 8080
ENTRYPOINT ["/app/apache-tomcat-10.1.48/bin/catalina.sh"]
CMD ["run"]
