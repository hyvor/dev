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
	helm upgrade -i hyvor ./helm --create-namespace --namespace hyvor -f ./infra/staging/values.staging.yaml

helm-uninstall:
	helm uninstall hyvor -n hyvor