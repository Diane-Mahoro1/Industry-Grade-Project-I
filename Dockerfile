FROM tomcat:9,0
Copy ABCtechnologies.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
