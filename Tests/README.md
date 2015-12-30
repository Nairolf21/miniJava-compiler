# Tests

## Terminology

* *test file*: any \*.java file to test
* *test target*: represents a ensemble of **test files** to test, usually to validate a new feature. It should have an explicit name, usually the feature to test (like `declaration`) 
* *test case*: defines the behaviour the compiler should have on a specific \*.java file.
For each **test target**, you can define several test cases
    * succes: this test case is mandatory. **Test files** for this **test case** must be files expected to be parsed correctly
