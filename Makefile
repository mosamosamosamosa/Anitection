dc := docker-compose -f ./docker-compose.yml

up:
	$(dc) up -d

up-debug:
	$(dc) --profile debug up

down:
	$(dc) down

restart:
	$(dc) restart

reup:
	@make down
	@make up

rm:
	$(dc) down --rmi all

logs:
	$(dc) logs -f