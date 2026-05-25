NAMESPACE=ecommerce

render-eks:
	kubectl kustomize overlays/eks-prod --enable-helm

apply-eks:
	kubectl kustomize overlays/eks-prod --enable-helm | kubectl apply -f -

delete:
	kubectl delete namespace $(NAMESPACE) --ignore-not-found=true

status:
	kubectl get pods -n $(NAMESPACE)
	kubectl get svc -n $(NAMESPACE)
	kubectl get deploy -n $(NAMESPACE)
	kubectl get statefulset -n $(NAMESPACE)

watch:
	kubectl get pods -n $(NAMESPACE) -w
