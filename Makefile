step=-----------------------

# HELP MENU
all: help
help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1.  make build    - Build image"
	@echo "   2.  make start    - Start container"
	@echo "   3.  make state    - Current state container"
	@echo "   4.  make logs     - Print logs container"
	@echo "   5.  make stop     - Stop container"
	@echo "   6.  make remove   - Remove container"
	@echo "   7.  make bash     - Launch container bash"
	@echo ""

# Manage
build:
	@echo "$(step) Building $(step)"
	@docker build --tag=huttopia/huttosoft-web:latest .

start:
	@echo "$(step) Starting $(step)"
	@docker run --name huttosoft-web -d -it huttopia/huttosoft-web:latest

state:
	@echo "$(step) Current state $(step)"
	@docker ps -a | grep huttosoft-web

logs:
	@echo "$(step) Logs $(step)"
	@docker logs -f huttosoft-web

stop:
	@echo "$(step) Stopping $(step)"
	@docker stop huttosoft-web

remove: stop
	@echo "$(step) Removing $(step)"
	@docker rm huttosoft-web

bash:
	@echo "$(step) Starting bash $(step)"
	@docker run --name huttosoft-web --rm -it huttopia/huttosoft-web:latest bash
