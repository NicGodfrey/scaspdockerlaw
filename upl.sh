#!/bin/sh
for f in codebase/*;
do
   echo "Copying $f..."
   docker cp $f qut_legal_coding:scasp/codebase
done