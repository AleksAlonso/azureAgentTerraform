#!/bin/sh

cd myagent

./config.sh remove --unattended --agent "AgenteLinux2" --url "https://dev.azure.com/mscdevops-ub" --auth PAT --token "" --pool "modulo7"

# stop the service
sudo ./svc.sh stop
#uninstall service
sudo ./svc.sh uninstall
