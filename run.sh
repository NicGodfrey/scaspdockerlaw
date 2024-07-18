#!/bin/bash
echo $( docker container inspect -f '{{.State.Status}}' qut_legal_coding )
if [ "$( docker container inspect -f '{{.State.Status}}' qut_legal_coding )" == "created" ]; 
then
	echo "Starting qut_legal_coding container..."
	docker start qut_legal_coding 
fi
if [ "$( docker container inspect -f '{{.State.Status}}' qut_legal_coding )" != "running" ]; 
then	
	echo "Starting qut_legal_coding container..."
	docker start qut_legal_coding 
fi
winpty docker exec -it -w //scasp//codebase qut_legal_coding bash