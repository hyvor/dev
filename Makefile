init:
	sh meta/sh/init.sh

dev:
	sh meta/sh/dev.sh $(C)
	sudo caddy run --config ./Caddyfile

compose-up:
	docker compose -f meta/docker-compose/docker-compose.yaml up -d
compose-down:
	docker compose -f meta/docker-compose/docker-compose.yaml down


helm:
	helm upgrade -i hyvor ./helm --create-namespace --namespace hyvor

helm-deploy-staging:
	# deploy staging-specific infra
	kubectl apply -k infra/staging/templates
	# deploy app
	helm upgrade -i hyvor ./helm --create-namespace --namespace hyvor -f ./helm/values.yaml -f ./infra/staging/values.staging.yaml

helm-uninstall:
	helm uninstall hyvor -n hyvor