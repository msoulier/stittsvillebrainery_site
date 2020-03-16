VER=
SITETAG=website:$(VER)
CWD=$(shell pwd)

all: site

site: VERSION_CHECK
	docker build --rm -f Dockerfile.site -t $(SITETAG) .

VERSION_CHECK:
ifeq ($(VER),)
	@echo "VER macro must be defined"
	@false
else
	@true
endif

push: VERSION_CHECK
	docker tag $(SITETAG) msoulier/stittsvillebrainery_site:$(VER)
	docker push msoulier/stittsvillebrainery_site:$(VER)

runsite: VERSION_CHECK
	docker run -it --rm -p 80:80 -p 443:443 --volume=$(CWD)/site:/var/www/html website:$(VER)

clean:
	-docker rm -v `docker ps -aq -f status=exited`
	-docker rmi `docker images -q -f dangling=true`

realclean: clean
	-docker volume prune -f
	-docker rm `docker ps -a -q`
	-docker rmi --force `docker images -q`
