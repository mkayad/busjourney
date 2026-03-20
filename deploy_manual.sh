#!/usr/bin/env bash
# Build your Java app
./gradlew  assemble -x test
# 1. Build

# 2. Deploy JAR
az webapp deploy \
  --resource-group busjourney-prod-rg \
  --name busjourney-prod \
  --src-path build/libs/busjourney.jar \
  --type jar

# 3. Check logs
az webapp log tail \
  --resource-group busjourney-prod-rg \
  --name busjourney-prod