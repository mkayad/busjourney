#!/usr/bin/env bash
./gradlew  assemble -x test
java  -Dstop.g.url=https://api.tfl.gov.uk/StopPoint/490000091G/arrivals?mode=bus  -Dstop.h.url=https://api.tfl.gov.uk/StopPoint/490000091H/arrivals?mode=bus -jar build/libs/busjourney.jar

