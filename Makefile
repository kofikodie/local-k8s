argocd-install:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
argocd-ui:
	kubectl port-forward svc/argocd-server -n argocd 8080:443
argocd-ui-lb:	
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
argocd-get-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
elb:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/aws/deploy.yaml

