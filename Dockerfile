FROM tomcat:latest
Copy abctechnologies.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
