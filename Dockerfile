FROM debian:jessie
MAINTAINER Christian Herold <christian.herold@die-mobilanten.de>

ENV TOMCATVER 7.0.64
ENV MOWITAVER 13200

RUN (apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless wget)
RUN (wget -O /tmp/tomcat7.tar.gz http://www.us.apache.org/dist/tomcat/tomcat-7/v${TOMCATVER}/bin/apache-tomcat-${TOMCATVER}.tar.gz && \
  cd /opt && \
  tar zxf /tmp/tomcat7.tar.gz && \
  mv /opt/apache-tomcat* /opt/tomcat && \
  rm /tmp/tomcat7.tar.gz)


ADD ./run.sh /usr/local/bin/run

ADD ./Server /opt/tomcat/mobilo/Server/

RUN (wget -O /opt/tomcat/webapps/web.war https://www.mobilanten.de/nexus/service/local/repositories/TempDeployForDocker/content/com/mobilanten/web/web/${MOWITAVER}/web-${MOWITAVER}.war)



### to deploy a specific war to ROOT, uncomment the following 2 lines and specify the appropriate .war
RUN rm -rf /opt/tomcat/webapps/docs /opt/tomcat/webapps/examples /opt/tomcat/webapps/ROOT
#ADD yourfile.war /opt/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["/usr/local/bin/run"]
