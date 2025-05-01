#!/bin/bash

WDIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

source $WDIR/pg-environment

function get-state() {
	podman inspect --type container "$1" | yq -p json '.[0].State.Status'
}

function run-container() {
	podman run --detach \
		--name "$1" \
		-e POSTGRES_PASSWORD=secret \
		-e PGDATA=/var/lib/postgresql/data/pgdata \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		docker.io/postgres:alpine 2>/dev/null
}

function start-container() {
	podman start "$1"
}

CONTAINER_NAME=bspg

run-container $CONTAINER_NAME
start-container $CONTAINER_NAME

echo Container $CONTAINER_NAME has state $(get-state $CONTAINER_NAME)
