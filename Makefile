DOCKER_BIN = docker
NAME = squid

# Including any Makefile extensions and allow overriding the above variables
-include $(wildcard Makefile.*)

.PHONY: build up down

build:
	docker build -t $(NAME) .
run:
	docker rm -f $(NAME) && docker run --name $(NAME) -p 5051:3128 squid
run2:
	docker rm -f $(NAME) && docker run --name $(NAME) -p 5051:3128 -e "USERNAME=proxynova" -e "PASSWORD=password" squid
test:
	curl -x localhost:5051 https://checkip.amazonaws.com/
test2:
	curl -x localhost:5051 -U proxynova:password https://checkip.amazonaws.com/
push:
	docker build --no-cache --file Dockerfile --tag athlon1600/squid-proxy-server:latest .
	docker push athlon1600/squid-proxy-server:latest
