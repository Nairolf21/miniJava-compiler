#!/bin/bash
echo "run args: $@"

testsDir=$(pwd)
rootDir=$testsDir"/.."

function testTargetDir() {
    if [ ! -d "$1" ]
    then 
        echo "test target $1 does not exist"
        exit
    fi
}

function runTestCase() {
    testCase="$1"
    reportFile="$2"


}

function runTargetTests() {
    
    target=$1
    targetDir=$testsDir"/"$target

    testTargetDir $targetDir
    successDir=$targetDir"/success"

    #Changing to project root directory to be able to use ocamlbuild
    originalDir=$(pwd)
    cd $rootDir

    reportFile="$targetDir""/reportFile"
    rm -f $reportFile

    echo "SUCCESS" >> $reportFile
    find $successDir -name "*.java" | while read filename
    do
        result=$(ocamlbuild Main.byte -- $filename)
        isSuccess=$(echo "$result" | grep -i "success")
        if [ "$isSuccess" == "" ]
        then
            echo $filename" FAILED" >> $reportFile
        else
            echo $filename" OK" >> $reportFile
        fi

    done

    #Print report
    echo "Target '$target' test results:"
    column -t $reportFile

    cd $originalDir
}


if [ "$1" == "all" ]
then
    #run tests on all targets
    echo "run all targets"
else
    runTargetTests $1
fi



