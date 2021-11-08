# Introduction 
Código terraform para desplegar un agente Linux en Azure DevOps

# Ejecutar la solución
Instalar terraform

Modify script.sh con tu propia información

modify tamops.tfvars si se desea

terraform init

terraform apply --var-file tamops.tfvars -auto-approve

