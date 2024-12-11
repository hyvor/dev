init:
	sh meta/sh/init.sh

serve:
	caddy run --config ./Caddyfile

compose-up:
	docker compose -f meta/docker-compose/docker-compose.yaml up -d
compose-down:
	docker compose -f meta/docker-compose/docker-compose.yaml down