# # # # # # # # # # # # # # # # # # # ## # # # # # # # # ## # # # # # # # # #
FROM eclipse-temurin:21-jre-alpine

EXPOSE 8080
ENV stop.g.url="https://api.tfl.gov.uk/StopPoint/490000091G/arrivals?mode=bus"
ENV stop.h.url="https://api.tfl.gov.uk/StopPoint/490000091H/arrivals?mode=bus"
ADD build/libs/busjourney.jar busjourney.jar

ENTRYPOINT ["java","-jar","busjourney.jar"]

