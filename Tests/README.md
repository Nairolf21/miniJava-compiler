# Tests

## Terminology

* *test file*: any \*.java file to test
* *test target*: represents a ensemble of **test files** to test, usually to validate a new feature. It should have an explicit name, usually the feature to test (like `declaration`) 
* *test case*: defines the behaviour the compiler should have on a specific \*.java file.
For each **test target**, you can define several test cases
    * succes: this test case is mandatory. **Test files** for this **test case** must be files expected to be parsed correctly
    * <ErrorName>: **Test files** for this **test case** must be files expected to throw a *ErrorName*
    

In all names, please don't use spaces.

## Test directory organization

*test target* and *test cases* are represented by directories, orginized in the following manner:

```
Tests
    | *<test_target1>*
        | *<test_case1>*
            | <Test1>.java
            | <Test2>.java
            | ...
        | *<test_case2>*
            | <Test1>.java
            | <Test2>.java
            | ...
    | *<test_target2>*
        | ...
```

To add a test target, a test case or a test file, do it "by hand"

To delete them, use the following command:

`./rmfile <directory or file>`

DO NOT delete by hand. If you do, make sure the files are effectively deleted from the worktree (with unix `rm`) AND git index (with `git rm`)
In doubt, use the rmfile command.

## Run tests

Open a terminal

`cd miniJava/Tests`

To run a test on a specific target

`./test.sh run <test_target>`

To run test on all test targets

`./test.sh run all`

For both use of `run`, the project is first build once with ocamlbuild. If there are compilation errors, the usual debug information
will be printed: fix the project before testing :)

If the compilation is succesful, the parser will try to parse each .java file in the test targets chosen. It will print the filename followed by *OK* if
the parser behaves as the test case commands it (either a succesful run, or an error throw). Otherwise, it will print *FAILED*. In this case, figure out what the problem is
in the normal development mode, and try to run the test again.

If all the targets are OK, it will print "SUCCESS" at the end of the message.


