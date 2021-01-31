pkgFile ?= deploy.tar.gz
localPath ?= ~/Documents/docker/tcmr

build:
	@tar czf $(pkgFile) --exclude=$(pkgFile) --exclude=.history --exclude=.git  ./
push: build
	scp $(pkgFile) tencent:$(pkgFile)
	ssh tencent "mkdir -p ./deploy && tar -zxf ./$(pkgFile) -C ./deploy --no-same-owner && mv deploy/docker-compose-sample.yml deploy/docker-compose.yml && mv deploy/env.sample deploy/.env && find . -type f -name '._*' -delete"
pushlocal: build
	scp $(pkgFile) tencent:$(pkgFile)
	mkdir -p $(localPath) && tar -zxf ./$(pkgFile) -C $(localPath) --no-same-owner && mv $(localPath)/docker-compose-sample.yml $(localPath)/docker-compose.yml && mv $(localPath)/env.sample $(localPath)/.env && find $(localPath) -type f -name '._*' -delete