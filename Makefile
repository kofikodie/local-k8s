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
argocd-install:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
argocd-ui:
	kubectl port-forward svc/argocd-server -n argocd 8080:443
argocd-get-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
