port-forward: 
	KUARD_POD=$(kubectl get pods -l app=kuard -o jsonpath='{.items[0].metadata.name}')
	kubectl port-forward $KUARD_POD 30080:8080
tls-screct: 
	kubectl create secret generic kuard-tls \
	--from-file=charts/certs/kuard.crt \
	--from-file=charts/certs/kuard.key
update-cm:
	kubectl create configmap my-config \
	--from-file=kuard-config.yml \
	--dry-run=client -o yaml | kubectl apply -f -
argo-install:
	kubectl create namespace argo
	kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-postgres.yaml
	kubectl port-forward svc/argocd-server -n argocd 8080:443
make argocd-get-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
