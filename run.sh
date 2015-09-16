#!/bin/bash
ADMIN_USER=${ADMIN_USER:-admin}
ADMIN_PASS=${ADMIN_PASS:-tomcat}
MAX_UPLOAD_SIZE=${MAX_UPLOAD_SIZE:-52428800}


HSQLDB_PORT=9001
CONFIG_DIR="/opt/tomcat/mobilo/Server/system/configuration"
MOWITA_OPTS="-DCONFIGDIR=${CONFIG_DIR} -Dmobilo.home=/opt/tomcat/mobilo/Server/system -DEMBEDDED=true -DEMBEDDED_PORT=${HSQLDB_PORT}"

CATALINA_OPTS=${CATALINA_OPTS:-"-Xms128m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=256m -Djava.security.egd=file:/dev/./urandom ${MOWITA_OPTS}"}
JAVA_OPTS="$JAVA_OPTS -XX:+CMSClassUnloadingEnabled ${MOWITA_OPTS}"
export CATALINA_OPTS="${CATALINA_OPTS}"
export JAVA_OPTS="${JAVA_OPTS}"


cat << EOF > /opt/tomcat/conf/tomcat-users.xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
<user username="${ADMIN_USER}" password="${ADMIN_PASS}" roles="admin-gui,manager-gui"/>
</tomcat-users>
EOF

cat << EOF > /opt/tomcat/conf/context.xml
<?xml version='1.0' encoding='utf-8'?>
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>

<Parameter name="CONFIGDIR" value="${CONFIG_DIR}"/>
<Parameter name="EMBEDDED_PORT" value="${HSQLDB_PORT}"/>
</Context>
EOF


if [ -f "/opt/tomcat/webapps/manager/WEB-INF/web.xml" ]
then
	sed -i "s#.*max-file-size.*#\t<max-file-size>${MAX_UPLOAD_SIZE}</max-file-size>#g" /opt/tomcat/webapps/manager/WEB-INF/web.xml
	sed -i "s#.*max-request-size.*#\t<max-request-size>${MAX_UPLOAD_SIZE}</max-request-size>#g" /opt/tomcat/webapps/manager/WEB-INF/web.xml
fi



exec /opt/tomcat/bin/catalina.sh run

