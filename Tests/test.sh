#!/bin/bash

command=$1

if [ "$command" == "run" ]
then
    shift
    ./run.sh $@
else
    echo "unknown command"
fi

