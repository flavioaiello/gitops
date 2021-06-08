list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: minikube
minikube:
	@echo "Sparking Minikube ..."
	minikube delete && minikube start
	kubectl apply -k argo-cd/overlays/minikube
	kubectl wait --for condition=established crd/applications.argoproj.io -n argocd --timeout=60s
	kubectl apply -k allspark/overlays/minikube
	kubectl wait --for condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	minikube service argocd-server -n argocd
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

.PHONY: gke
gke:
	@echo "Sparking GKE ..."
	kubectl apply -k overlays/gke
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

.PHONY: eks
eks:
	@echo "Sparking EKS ..."
	kubectl apply -k overlays/eks
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'