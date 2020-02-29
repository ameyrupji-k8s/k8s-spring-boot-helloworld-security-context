FROM openjdk:8-jre-alpine

# Copy code to docker container
COPY ./target/com.ameyrupji.helloworld-1.0-SNAPSHOT.jar /helloworld.jar
COPY ./procfile procfile
RUN chmod 755 /procfile

# Setup a non-root user context.
# This prevents application from overeritting itself and a good security measure 
# Required for AWS EKS > 1.14 

RUN addgroup -g 1988 arupji-helloworld-group
RUN adduser -D -s / -u 1988 arupji-helloworld-user -G arupji-helloworld-group

RUN chown 1988:1988 helloworld.jar \
&& chown 1988:1988 procfile

USER 1988

CMD /procfile
