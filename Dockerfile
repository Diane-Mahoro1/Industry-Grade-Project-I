FROM tomcat:9,0
Copy abctechnologies.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
