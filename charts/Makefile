port-forward: 
	KUARD_POD=$(kubectl get pods -l app=kuard -o jsonpath='{.items[0].metadata.name}')
	kubectl port-forward $KUARD_POD 30080:8080
tls-screct: 
	kubectl create secret generic kuard-tls \
	--from-file=certs/kuard.crt \
		--from-file=certs/kuard.key
update-cm:
	kubectl create configmap my-config \
	--from-file=kuard-config.yml \
	--dry-run=client -o yaml | kubectl apply -f -
