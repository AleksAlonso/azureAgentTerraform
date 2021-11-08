#!/bin/sh

# Creates directory & download ADO agent install files
token = $1
mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/2.194.0/vsts-agent-linux-x64-2.194.0.tar.gz
tar zxvf vsts-agent-linux-x64-2.194.0.tar.gz

./bin/installdependencies.sh

./config.sh --unattended --agent "AgenteLinux" --url "https://dev.azure.com/mscdevops-ub" --auth PAT --token "" --pool "modulo7" --replace --acceptTeeEula

# #Configure as a service
sudo ./svc.sh install modulo7

# #Start svc
sudo ./svc.sh start