# FROM adoptopenjdk/openjdk11:alpine-slim
# RUN apt-get update -y && apt-get install maven -y
#
# RUN mkdir -p app/busjourney
#
# WORKDIR app/busjourney
#
# COPY . .
# RUN mvn clean package
#
# EXPOSE 8080
# # CMD [ "spring-boot-template.jar" ]
# #
# # RUN mkdir /app
# # COPY target/*.jar /app/spring-boot-application.jar
#
# ENTRYPOINT ["java","-jar","/target/busjourney-0.0.1-SNAPSHOT.jar"]
# FROM tomcat:9.0-jre8-alpine
#
# COPY target/wizard*.war $CATALINA_HOME/webapps/wizard.war
#
# HEALTHCHECK --interval=1m --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:8080/wizard/ || exit 1
#

from java:8

EXPOSE 8080

ADD target/busjourney.jar busjourney.jar

ENTRYPOINT ["java","-jar","busjourney.jar"]
