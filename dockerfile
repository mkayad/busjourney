# # # # # # # # # # # # # # # # # # # ## # # # # # # # # ## # # # # # # # # #
# this below works with fabric8 and spotify plugin where the host machine is supposed to have a jdk env setup
# from java:8
#
# EXPOSE 8080
#
# ADD target/busjourney.jar busjourney.jar
#
# ENTRYPOINT ["java","-jar","busjourney.jar"]
# # # # # # # # # ## # # # # # # # # ## # # # # # # # # ## # # # # # # # # #

FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package
#
# FROM tomcat:9.0-jre8-alpine
# COPY --from=MAVEN_TOOL_CHAIN /tmp/target/wizard*.war $CATALINA_HOME/webapps/wizard.war
#
# HEALTHCHECK --interval=1m --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:8080/wizard/ || exit 1
from java:8

COPY --from=MAVEN_TOOL_CHAIN /tmp/target/busjourney.jar  .

EXPOSE 8080

# ADD target/busjourney.jar busjourney.jar
# HEALTHCHECK --interval=1m --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:8080 || exit 1
 ENTRYPOINT ["java","-jar","busjourney.jar"]
