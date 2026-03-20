#!/bin/bash

set -e

KV_NAME="busjourney-prod-kv-2"
RG="busjourney-prod"

echo "========================================"
echo "Azure Key Vault Connection Test"
echo "========================================"

# Test 1: Check if Key Vault exists
echo ""
echo "✓ Test 1: Checking if Key Vault exists..."
az keyvault show \
  --name $KV_NAME \
  --resource-group $RG \
  --query "name" -o tsv

# Test 2: List all secrets
echo ""
echo "✓ Test 2: Listing all secrets..."
az keyvault secret list \
  --vault-name $KV_NAME \
  --query "[].name" -o tsv

# Test 3: Get specific secret
echo ""
echo "✓ Test 3: Getting mysql-password secret..."
SECRET_VALUE=$(az keyvault secret show \
  --vault-name $KV_NAME \
  --name mysql-connection-string \
  --query value -o tsv)
echo $SECRET_VALUE
if [ -z "$SECRET_VALUE" ]; then
  echo "✗ Secret is empty!"
  exit 1
else
  echo "✓ Secret retrieved successfully ( ${#SECRET_VALUE})"
fi

# Test 4: Check access policies
echo ""
echo "✓ Test 4: Checking access policies..."
az keyvault show \
  --name $KV_NAME \
  --query "properties.accessPolicies[].{ObjectId:objectId, Permissions:permissions.secrets}" -o table

# Test 5: Check if running on Azure VM with Managed Identity
echo ""
echo "✓ Test 5: Testing Managed Identity..."
if az login --identity 2>/dev/null; then
  echo "✓ Managed Identity login successful"

  # Try to access Key Vault with Managed Identity
  RESULT=$(az keyvault secret show \
    --vault-name $KV_NAME \
    --name mysql-password \
    --query value -o tsv 2>&1)

  if [ $? -eq 0 ]; then
    echo "✓ Managed Identity can access Key Vault"
  else
    echo "✗ Managed Identity cannot access Key Vault"
    echo "Error: $RESULT"
  fi
else
  echo "ℹ Not running on Azure VM with Managed Identity (expected if running locally)"
fi

echo ""
echo "========================================"
echo "Key Vault Connection Test Complete ✓"
echo "==="
