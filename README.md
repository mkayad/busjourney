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
docker run -d -p 8080:8080 busjourney
