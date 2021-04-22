#!/bin/bash

# Create a resource group.
az group create --name myResourceGroup2 --location westeurope

# Create a Batch account.
az batch account create     --resource-group myResourceGroup2     --name mybatchaccount2     --location westeurope

# Authenticate Batch account CLI session.
az batch account login     --resource-group myResourceGroup2     --name mybatchaccount2    --shared-key-auth

# Retrieve a list of available images and node agent SKUs.
az batch pool node-agent-skus list

# Create a new Linux pool with a virtual machine configuration. The image reference 
# and node agent SKUs ID can be selected from the ouptputs of the above list command.
# The image reference is in the format: {publisher}:{offer}:{sku}:{version} where {version} is
# optional and defaults to 'latest'.
az batch pool create \
    --id mypool-linux \
    --vm-size Standard_A1 \
    --image canonical:ubuntuserver:16.04-LTS \
    --node-agent-sku-id "batch.node.ubuntu 16.04"

# Resize the pool to start some VMs.
az batch pool resize \
    --pool-id mypool-linux \
    --target-dedicated 5

# Check the status of the pool to see when it has finished resizing.
az batch pool show \
    --pool-id mypool-linux

# List the compute nodes running in a pool.
az batch node list \
    --pool-id mypool-linux
