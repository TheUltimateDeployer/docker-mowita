#!/bin/sh
#

CATALINA_HOME=/usr/share/tomcat7
export JAVA_OPTS="$JAVA_OPTS -DEMBEDDED_PORT=62616"
# The first existing directory is used for JAVA_HOME (if JAVA_HOME is not
# defined in $DEFAULT)
JDK_DIRS="/usr/lib/jvm/java-6-openjdk /usr/lib/jvm/java-6-sun /usr/lib/jvm/java-1.5.0-sun /usr/lib/j2sdk1.5-sun /usr/lib/j2sdk1.5-ibm"

# Look for the right JVM to use
for jdir in $JDK_DIRS; do
    if [ -r "$jdir/bin/java" -a -z "${JAVA_HOME}" ]; then
	JAVA_HOME_TMP="$jdir"
	# checks for a real JDK like environment, needed to check if 
	# really the java-gcj-compat-dev package is installed
	if [ -r "$jdir/bin/jdb" ]; then
	    JAVA_HOME="$JAVA_HOME_TMP"
	fi
    fi
done

# Default Java options
if [ -z "$JAVA_OPTS" ]; then
	JAVA_OPTS="-Djava.awt.headless=true -Xmx128M"
fi
export CATALINA_OPTS="-Dappserver.home=/var/lib/tomcat7/13200 -Dappserver.base=/var/lib/tomcat7/13200"
