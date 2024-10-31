#!/bin/bash

while true
do
    cat /servlog/access.log | wc -l
    sleep 10
done
