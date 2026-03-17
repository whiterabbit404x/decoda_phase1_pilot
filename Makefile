.PHONY: dev test web worker compose-up compose-down

dev:
	uvicorn app.main:app --reload

test:
	pytest -q

web:
	./scripts/start-web.sh

worker:
	./scripts/start-worker.sh

compose-up:
	docker compose -f docker-compose.production.yml up --build

compose-down:
	docker compose -f docker-compose.production.yml down
