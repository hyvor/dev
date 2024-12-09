init:
	sh meta/sh/init.sh

compose-up:
	docker compose -f meta/docker-compose/docker-compose.yaml up -d
compose-down:
	docker compose -f meta/docker-compose/docker-compose.yaml down