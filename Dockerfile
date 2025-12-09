FROM tomcat:9.0
COPY abctechnologies.war /usr/local/tomcat/webapps
ENV CATALINA_OPTS="-Xms128m -Xmx256m"
CMD ["catalina.sh", "run"]