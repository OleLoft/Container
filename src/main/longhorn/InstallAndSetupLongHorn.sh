#!/bin/bash
echo "Start - Installing Longhorn"
echo ""

sleep 2s

echo "Start - apply longhorn"
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.8.1/deploy/longhorn.yaml
echo "End   - apply longhorn"
echo ""

sleep 2s

# echo "Start - check deployment"
# kubectl get pods \--namespace longhorn-system \--watch
# echo "End  - Check deployment"

bash ./CreateUser.sh

echo "End   - Installing Longhorn"


