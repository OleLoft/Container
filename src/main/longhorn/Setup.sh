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

echo "
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: longhorn-ingress
  namespace: longhorn-system
  annotations:
    # type of authentication
    nginx.ingress.kubernetes.io/auth-type: basic
    # prevent the controller from redirecting (308) to HTTPS
    nginx.ingress.kubernetes.io/ssl-redirect: 'false'
    # name of the secret that contains the user/password definitions
    nginx.ingress.kubernetes.io/auth-secret: basic-auth
    # message to display with an appropriate context why the authentication is required
    nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required '
spec:
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: longhorn-frontend
            port:
              number: 80
" | kubectl -n longhorn-system create -f -

sleep 2s

kubectl -n longhorn-system get ingress

sleep 2s

curl -v http://97.107.142.125/ -u foo:bar

echo "End   - Installing Longhorn"
echo ""





