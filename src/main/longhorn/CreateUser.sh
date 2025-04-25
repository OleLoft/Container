echo "Start - Executing script to create user"
echo ""

sleep 2s

echo "Start - Create user"
USER=olel; PASSWORD=olel; echo "${USER}:$(openssl passwd -stdin -apr1 <<< ${PASSWORD})" >> auth
echo "End   - Create user"

sleep 2s

echo "Start - Create secret, basic auth"
kubectl -n longhorn-system create secret generic basic-auth --from-file=auth
echo "Start - Create secret, basic auth"

sleep 2s

echo "Start - Create secret, basic auth"
kubectl -n longhorn-system apply -f longhorn-ingress.yml
echo "End   - Create secret, basic auth"

sleep 2s

echo "Start - Get auth token"
cat auth
echo "End   - Get auth token"

sleep 2s

echo "End   - Executing script to create user"
