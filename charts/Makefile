port-forward: 
	KUARD_POD=$(kubectl get pods -l app=kuard -o jsonpath='{.items[0].metadata.name}')
	kubectl port-forward $KUARD_POD 30080:8080