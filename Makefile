.PHONY: run env_copy login

env_copy:
	cp .env.example .env

run:
	docker compose up -d

login:
	docker compose exec -it devops-toolkit /bin/bash
