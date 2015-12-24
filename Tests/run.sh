#!/bin/bash
echo "run args: $@"

testsDir=$(pwd)
rootDir=$testsDir"/.."

target=$1
targetDir=$testsDir"/"$target

function testTarget() {
    #echo "targetDir to test: $1"
    if [ ! -d "$1" ]
    then 
        echo "test target $1 does not exist"
        exit
    fi
}


testTarget $targetDir

successDir=$targetDir"/success"

cd $rootDir

find $successDir -name "*.java" | while read filename
do
    echo ""
    echo "Testing file $filename"
    result=$(ocamlbuild Main.byte -- $filename)
    isSuccess=$(echo "$result" | grep "SUCCESS")
    echo "$isSuccess"
    if [ "$isSuccess" == "" ]
    then
        echo $filename" FAILED"
    else
        echo $filename" OK"
    fi

done

exit
ls $successDir | egrep "*.java" | while read line
do
    ocamlbuild Main.byte -- "$line"
done




