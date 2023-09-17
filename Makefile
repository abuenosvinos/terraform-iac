CONTAINER := terraform_instance

.PHONY: help
help: ## show make targets
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: ## Create the container
	@docker build . -t terraform_instance -f docker/terraform/Dockerfile

run: ## Connect to the instance
	@docker run -ti --rm -v ./terraform:/app -v ~/.aws:/root/.aws --user $(id -u):$(id -g) terraform_instance bash
