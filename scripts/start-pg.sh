#!/bin/bash

podman run --detach \
	--name bspg \
	-e POSTGRES_PASSWORD=secret \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v pgdata:/var/lib/postgresql/data \
	-p 5432:5432 \
	docker.io/postgres:alpine
