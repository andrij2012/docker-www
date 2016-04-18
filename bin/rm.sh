#!/bin/sh

SCRIPT=$(readlink -f "0")
BASEDIR=$(dirname "$SCRIPT")

cd $BASEDIR && docker-compose rm