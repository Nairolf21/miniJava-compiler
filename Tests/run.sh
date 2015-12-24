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

function listTestCases() {
    targetDir=$1

    find $targetDir -maxdepth 1 -mindepth 1 -type d | while read line
    do 
        count=$(find $line -name "*.java" | wc -l)
        if [ $count -gt 0 ]
        then
            echo $line | rev | cut -d "/" -f 1 | rev
        fi
    done
}


function runTestCase() {
    targetDir="$1"
    testCase="$2"
    reportFile="$3"

    testCaseDir="$targetDir""/$testCase"

    #Changing to project root directory to be able to use ocamlbuild
    originalDir=$(pwd)
    cd $rootDir

    echo "$testCase" >> $reportFile
    find $testCaseDir -name "*.java" | while read filename
    do
        result=$(ocamlbuild Main.byte -- $filename)
        isSuccess=$(echo "$result" | grep -i "$testCase")
        if [ "$isSuccess" == "" ]
        then
            echo $filename"|FAILED" >> $reportFile
        else
            echo $filename"|OK" >> $reportFile
        fi

    done

    cd $originalDir
}

function runTargetTests() {
    
    target=$1
    targetDir=$testsDir"/"$target

    testTargetDir $targetDir
    successDir=$targetDir"/success"


    reportFile="$targetDir""/reportFile"

    echo "Target '$target' test results:" > $reportFile

    echo "Listing test cases"
    listTestCases $targetDir | while read tc
    do
        runTestCase $targetDir $tc $reportFile
    done

    #Print report
    column -t -s "|" $reportFile

}


if [ "$1" == "all" ]
then
    #run tests on all targets
    echo "run all targets"
else
    runTargetTests $1
fi



