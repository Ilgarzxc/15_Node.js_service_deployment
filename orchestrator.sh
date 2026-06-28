#!/bin/bash

set -euo pipefail

cd terraform
terraform apply -auto-approve

IP=$(terraform output -raw public-ip-for-compute-instance)
VM=$(terraform output -raw name)

cd ../ansible

cat > inventory.yaml << EOF
staging:
    hosts:
        staging-vm:
            ansible_host: $IP
            ansible_user: ubuntu
            ansible_group: ubuntu
EOF

mkdir -p ~/.ssh/config.d

cat > ~/.ssh/config.d/oracle_${VM} << EOF
Host $VM
    HostName $IP
    User ubuntu
    IdentityFile ~/.oci/id_ed25519_oracle
EOF

ssh-keygen -R "$IP"