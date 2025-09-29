#!/bin/bash
RESOURCE_GROUP="rg-fiap-tracking-api"
LOCATION="eastus2"
SQL_SERVER_NAME="sqlsrv-fiap-tracking-$(date +%s)"
SQL_ADMIN_USER="fiapAdmin"
SQL_ADMIN_PASSWORD="FiapTracking2025!"

echo "Criando SQL Server..."
az sql server create \
  --resource-group $RESOURCE_GROUP \
  --name $SQL_SERVER_NAME \
  --location $LOCATION \
  --admin-user $SQL_ADMIN_USER \
  --admin-password $SQL_ADMIN_PASSWORD \
  --enable-public-network true

echo "SQL Server criado: $SQL_SERVER_NAME.database.windows.net"
echo "Salve este nome para os próximos scripts!"