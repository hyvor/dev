init:
	sh meta/sh/init.sh

dev:
	sh meta/sh/dev.sh $(C)
	sudo caddy run --config ./Caddyfile

compose-up:
	docker compose -f meta/docker-compose/docker-compose.yaml up -d
compose-down:
	docker compose -f meta/docker-compose/docker-compose.yaml down