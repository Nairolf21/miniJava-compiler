#!/bin/bash
echo "run args: $@"

testsDir=$(pwd)
rootDir=$testsDir"/.."

testResultFile=$testsDir"/testResult.ign"
rm -f $testResultFile

function compileProject() {
    echo "Compiling project..."
    echo ""

    originalDir=$(pwd)
    cd $rootDir
    rm -f Main.native

    compilationResult=$(ocamlbuild Main.native)
    
    if [ -f Main.native ]
    then
        echo "Project compilation succesful"
    else
        echo "Compilation failed with the following message:"
        echo ""
        echo "--------"
        echo "$compilationResult"
        echo "--------"
        echo ""
        echo "Fix the project before testing. Exiting Test script"
        exit
    fi

    echo ""

    cd $originalDir
}

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

function listTargets() {
    find $testsDir -maxdepth 1 -mindepth 1 -type d | while read line
    do
        testcasecount=$(listTestCases "$line" | wc -l)
        #echo "dir $line"": $testcasecount test cases"
        if [ $testcasecount -gt 0 ]
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

    echo "Test case: $testCase" >> $reportFile
    find $testCaseDir -name "*.java" | while read filename
    do
        result=$(./Main.native $filename)
        isSuccess=$(echo "$result" | grep -i "$testCase")
        printfilename=$filename
        if [ "$isSuccess" == "" ]
        then
            echo $printfilename"|FAILED" >> $reportFile
        else
            echo $printfilename"|OK" >> $reportFile
        fi

    done

    cd $originalDir
}

function runTargetTests() {
    
    target=$1
    targetDir=$testsDir"/"$target

    testTargetDir $targetDir
    successDir=$targetDir"/success"


    reportFile="$targetDir""/reportFile.ign"

    echo "Target '$target' test results:" > $reportFile

    listTestCases $targetDir | while read tc
    do
        runTestCase $targetDir $tc $reportFile
    done

    #count failed occurences
    failedCount=$(grep -c -i "failed" $reportFile)
    if [ $failedCount -gt 0 ]
    then
        testResult="Target test '$target' FAILED"
    else
        testResult="Target test '$target' OK"
    fi

    echo $testResult >> $reportFile
    echo $testResult >> $testResultFile

    #Print report
    echo ""
    echo " ------ "
    echo ""
    column -t -s "|" $reportFile

}

function printResult() {
    echo ""
    echo "===== "

    failedCount=$(grep -i -c "FAILED" $testResultFile)

    if [ $failedCount -gt 0 ]
    then
        echo "The test run FAILED"
    else
        echo "The test run SUCCESS"
    fi

    echo ""
}

compileProject

if [ "$1" == "all" ]
then
    #run tests on all targets
    listTargets | while read target
    do
    runTargetTests $target
    done
else
    runTargetTests $1
fi

printResult

