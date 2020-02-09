VER=
SITETAG=website:$(VER)

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

runsite: VERSION_CHECK
	docker run -it --rm -p 80:80 -p 443:443 website:$(VER)

clean:
	-docker rm -v `docker ps -aq -f status=exited`
	-docker rmi `docker images -q -f dangling=true`

realclean: clean
	-docker volume prune -f
	-docker rm `docker ps -a -q`
	-docker rmi --force `docker images -q`
