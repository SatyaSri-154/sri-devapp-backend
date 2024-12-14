FROM tomcat:8
MAINTAINER sri.devapp.com
#Take the war file and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/sridevapp.war
CMD ["catalina.sh", "run"]
EXPOSE 8080