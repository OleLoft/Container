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

sleep 2s

echo "Start - Create user"
USER=olel; PASSWORD=olel; echo "${USER}:$(openssl passwd -stdin -apr1 <<< ${PASSWORD})" >> auth
echo "End   - Create user"

sleep 2s

echo "Start - Get auth token"
cat auth
echo "End   - Get auth token"

sleep 2s

echo "Start - Create secret, basic auth"
kubectl -n longhorn-system create secret generic basic-auth --from-file=auth
echo "Start - Create secret, basic auth"

sleep 2s

echo "Start - Create secret, basic auth"
kubectl -n longhorn-system apply -f longhorn-ingress.yml
echo "End   - Create secret, basic auth"



kubectl -n longhorn-system get secret basic-auth -o yaml








sleep 2s

echo "Start - Get svc"
kubectl -n longhorn-system get svc
echo "End   - Get svc"

sleep 2s

echo "Start - Get cluster-ip"
Get the frontend cluster-ip
echo "End   - Get cluster-ip"

sleep 2s

echo "Start - Get secret"
kubectl -n longhorn-system get secret basic-auth -o yaml
echo "End   - Get secret"

sleep 2s

echo "Start - Get svc"
kubectl -n longhorn-system get svc
echo "End   - Get svc"

echo "End   - Installing Longhorn"


