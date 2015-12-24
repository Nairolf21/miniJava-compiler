#!/bin/bash
echo "run args: $@"

testsDir=$(pwd)
rootDir=$testsDir"/.."

target=$1
targetDir=$testsDir"/"$target

function testTarget() {
    if [ ! -d "$1" ]
    then 
        echo "test target $1 does not exist"
        exit
    fi
}


testTarget $targetDir

successDir=$targetDir"/success"

originalDir=$(pwd)
cd $rootDir
reportFile='reportFile'
rm -f $reportFile
find $successDir -name "*.java" | while read filename
do
    result=$(ocamlbuild Main.byte -- $filename)
    isSuccess=$(echo "$result" | grep "SUCCESS")
    if [ "$isSuccess" == "" ]
    then
        echo $filename" FAILED" >> $reportFile
    else
        echo $filename" OK" >> $reportFile
    fi

done

#Print report
echo "$target results:"
column -t $reportFile

cd $originalDir




