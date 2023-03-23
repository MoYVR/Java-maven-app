#!/usr/bin/env bash

export IMAGE=
docker-compose -f docker-compose.yaml up --detach
echo "success"
