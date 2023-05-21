Build & Tag the Image <br>
```
docker build -t photomosaicv2.azurecr.io/photomosaicv2api:latest .
```

Other commands
- `docker login photomosaicv2.azurecr.io`
- `docker push photomosaicv2.azurecr.io/photomosaicv2api`
- `docker image ls`


Documentation References
- [Documentation about connecting to Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-powershell)
- [Import Terraform Configuration](https://developer.hashicorp.com/terraform/tutorials/state/state-import?utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS)

Log in to a registry
```
Connect-AzAccount
Connect-AzContainerRegistry -Name myregistry
```

Notes for Future Nick
- The Image will be deployed to the App Service when it has been uploaded to ACR (Azure Container Registry)
- You can create resources in Azure then Import that resource into the State, once that has been done you can view the Terraform State & manually copy the State Configuration into your own to migrate it.

