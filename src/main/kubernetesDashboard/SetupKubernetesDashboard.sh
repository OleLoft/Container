echo "Start - Running script to setup kubernetes dashboard"
echo ""

sleep 2s

echo "Start - deleting old namespace kubernetes-dashboard"
bash ../Tool/DeleteNamespace.sh -n kubernetes-dashboard
echo "End   - deleting old namespace kubernetes-dashboard"

sleep 2s

echo "Start - getting dashboard repo"
# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
echo "End   - getting dashboard repo"
echo ""

sleep 2s

echo "Start - install repo"
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
echo "End   - install repo"
echo ""

sleep 2s

echo "Start - Apply Service Account user"
kubectl apply -f ServiceAccount.yaml
echo "End   - Apply Service Account user"
echo ""

sleep 2s

echo "Start - Apply cluster role binding"
kubectl apply -f ClusterRoleBinding.yaml 
echo "End   - Apply cluster role binding"
echo ""

sleep 2s

echo "Start - Create token to admin user"
kubectl -n kubernetes-dashboard create token admin-user
echo "End   - Create token to admin user"
echo "NB: Use token to login"
echo ""

sleep 30s

echo "Start - Port forwarding. Access dashboard goto https://localhost:8453 i browser and use token"
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8453:443
echo "End   - Port forwarding"
echo ""

echo "End   - Running script to setup kubernetes dashboard"
