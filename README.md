# busjourney
This project is for displaying the buses coming to **Great Portland Street station (G & H)** in London

# System requirements
This project requires **Java 8** and **Maven**, it also uses **Kotlin**.

# how to run
in terminal window, **clone the repo to a folder** 
Go to the project folder and **run mvn spring-boot:run**

# how to access 
open a browser window and type **http://localhost:8080**

the page will refresh itself every 10 seconds
dummy commit for Azure app service

# docker 
docker build -t busjourney .
docker buildx build -t busjourney --platform linux/amd64 .
docker run -d -p 8080:8080 busjourney

Azure 
create a container registry resource
go to settings/access keys and enable admin user
get the user, pwd, url

az login
docker login apppregistry2025.azurecr.io

docker image ls

docker tag busjourney:latest apppregistry2025.azurecr.io/busjourney:latest

docker tag busjourney:latest apppregistry2025.azurecr.io/busjourney:latest
docker push  apppregistry2025.azurecr.io/busjourney:latest


Note:
When creating the container instance, don't forget to specify the port (8080).
example: http://172.187.120.203:8080/