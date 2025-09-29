#!/bin/bash
RESOURCE_GROUP="rg-fiap-tracking-api"
SQL_SERVER_NAME=""  # Obtido do script 02
SQL_DATABASE_NAME="motosdb"

echo "Criando SQL Database..."
az sql db create \
  --resource-group $RESOURCE_GROUP \
  --server $SQL_SERVER_NAME \
  --name $SQL_DATABASE_NAME \
  --service-objective Basic \
  --collation "SQL_Latin1_General_CP1_CI_AS"

echo "Database criado: $SQL_DATABASE_NAME"