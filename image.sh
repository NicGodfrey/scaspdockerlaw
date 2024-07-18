#!/bin/sh
docker build --no-cache -t swi-casp .
docker create -it --name qut_legal_coding swi-casp
sh upl.sh