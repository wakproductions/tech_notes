### Login to Azure
```
az login
az acr login -n aichatbotregistry
```



### Create tags for Docker repo

```
docker tag moser-inc/ai-chatbot-rails:latest aichatbotregistry.azurecr.io/moser-inc/ai-chatbot-rails:latest
docker tag moser-inc/ai-chatbot-rails:latest aichatbotregistry.azurecr.io/moser-inc/ai-chatbot-rails:v0.0.<datetimestamp>

docker push aichatbotregistry.azurecr.io/moser-inc/ai-chatbot-rails:latest
docker push aichatbotregistry.azurecr.io/moser-inc/ai-chatbot-rails:v.0.0.2
```

### Pull the Docker repo

```
docker pull aichatbotregistry.azurecr.io/moser-inc/ai-chatbot-rails:latest
```

### Run it

```
docker compose up
```