FROM alpine:latest
ENV WILDFLY_VERSION 24.0.0.Final
ENV WILDFLY_SHA1 391346c9ed2772647ff07aeae39deb838ee11dcf 
RUN set -x \
    apk add --update && \
    apk add curl wget tar openjdk8 curl && \
    addgroup -g 10000 -S wildfly && \
    adduser -S -D -H -u 10000 -h /opt/wildfly -s /sbin/nologin -G wildfly -g wildfly wildfly && \
    cd /opt/ && \
    wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz  && \
    sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 && \
    tar xvf wildfly-$WILDFLY_VERSION.tar.gz && \
    rm -rf /opt/wildfly-$WILDFLY_VERSION.tar.gz && \
    mv wildfly-$WILDFLY_VERSION wildfly  && \
    chown -R wildfly:wildfly /opt/wildfly && \
    rm -rf /tmp/* /var/cache/apk/* 

EXPOSE 8080 9990
USER wildfly
WORKDIR /opt/wildfly
CMD ["/opt/wildfly/bin/standalone.sh", "-c", "standalone.xml", "-b" , "0.0.0.0" ]
    
