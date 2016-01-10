public class Blocks {
    // empty block
    void foo1() {}
    
    // one block statement : block statement local variable
    void foo2() {
    	int i = 0;
    }
    
    //one block statement : class declaration
    void foo3() {
    	class innerBlocks {}
	}    

    //one block statement : statement (statementWithoutTrailingSubstatement / empty block)
    void foo4(){
    	{}
    }
    
    //multiple statements
    void foo5(){
    	int i = 0;
    	class subBlocks {}
    	{}
    }
}
