SUFFIX=XXXX; RG=rg-stock-agent; LOC=eastus2
ST=ststockagent$SUFFIX; LA=la-stock-mcp-$SUFFIX
FOUNDRY=foundry-stock-$SUFFIX; PROJECT=stock-agent-project

az group create --name $RG --location $LOC --tags project=stock-agent
az storage account create --name $ST --resource-group $RG --location $LOC --sku Standard_LRS --kind StorageV2 --min-tls-version TLS1_2 --allow-blob-public-access false
az storage table create --name StockQuotes --account-name $ST --auth-mode key
az cognitiveservices account create --name $FOUNDRY --resource-group $RG --location $LOC --kind AIServices --sku S0 --custom-domain $FOUNDRY --assign-identity --allow-project-management true
az cognitiveservices account project create --name $FOUNDRY --resource-group $RG --project-name $PROJECT --location $LOC
az cognitiveservices account deployment create --name $FOUNDRY --resource-group $RG --deployment-name gpt-5.4-mini --model-name gpt-5.4-mini --model-version "2026-03-17" --model-format OpenAI --sku-name DataZoneStandard --sku-capacity 30