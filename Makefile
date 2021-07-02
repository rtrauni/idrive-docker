.PHONY: all

all:
	docker build -t idrive .

run:
	docker run \
		--name idrive \
		--hostname idrive-x1c7-docker \
		--mac-address="02:43:ac:36:ea:e3" \
		-d \
		-e PGID=$$(id -g) \
		-e PUID=$$(id -u) \
		-v $(HOME)/localdata/dotfiles/idrive:/work/IDriveForLinux/idriveIt \
		-v /:/backup:ro \
		idrive

kill:
	docker kill idrive
	docker rm idrive

shell:
	docker exec -it idrive /bin/bash
