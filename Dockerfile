FROM tomcat:9.0
COPY abctechnologies.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
