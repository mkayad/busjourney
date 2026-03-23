#!/usr/bin/env bash
./gradlew  assemble -x test
# Build image
docker build -t busjourney:latest .

# Tag for Azure Container Registry
docker tag busjourney:latest fabtek1000.azurecr.io/busjourney:latest

# Push to ACR
az acr build \
  --registry fabtek1000 \
  --image busjourney:latest .

  az keyvault update \
    --name busjourney-prod-kv-2 \
    --resource-group busjourney-prod \
    --default-action Allow \
    --bypass AzureServices