pkgFile ?= deploy.tar.gz

build:
	@tar czf $(pkgFile) --exclude=$(pkgFile) --exclude=.history --exclude=.git  ./
push: build
	scp $(pkgFile) tencent:$(pkgFile)
	ssh tencent "mkdir -p ./deploy && tar -zxf ./$(pkgFile) -C ./deploy --no-same-owner && mv deploy/docker-compose-sample.yml deploy/docker-compose.yml && mv deploy/env.sample deploy/.env && find . -type f -name '._*' -delete"