DOCKER_BIN = docker
NAME = squid
IMAGE_NAME = athlon1600/squid-proxy-server:latest

# Including any Makefile extensions and allow overriding the above variables
-include $(wildcard Makefile.*)

.PHONY: build up down

actions:
	act -W .github/workflows/docker-build-push.yml workflow_dispatch --secret-file .env
okay:
	@echo "✅ All commands executed successfully!"
build:
	docker build --file Dockerfile --tag $(IMAGE_NAME) .
build2:
	docker build --no-cache --file Dockerfile --tag $(IMAGE_NAME) .
reload:
	docker compose exec $(NAME) bash -c "squid -k reconfigure"
run:
	docker run --name $(NAME) -p 5051:3128 --detach $(IMAGE_NAME)
run2:
	docker run --name $(NAME) -p 5051:3128 -e "USERNAME=proxynova" -e "PASSWORD=password" --detach $(IMAGE_NAME)
remove:
	docker rm -f $(NAME)
test:
	curl -x localhost:5051 https://checkip.amazonaws.com/
test2:
	curl -x localhost:5051 -U proxynova:password https://checkip.amazonaws.com/
push:
	docker push $(IMAGE_NAME)
