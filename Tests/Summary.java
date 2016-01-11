class Summary {

    A(){}
    B(){}
    
    public A(){}
    private B(){}
    protected B(){}

    void foo() {
        
        a *= 12;
        a /= 12;
        a %= 12;
        a += 12;
        a -= 12;
        a <<= 2;
        a >>= 2;
        a >>>= 2;
        a &= 1;
        a ^= 1;
        
        a = b = 3;
        a = a ? b : c;
        a = b %= c;
        
        
        
        }
        
        void emptyBlock() {}
    
        void oneBlockStatementBlockStatementLocalVariable() {
            final int i;
        }
        
        void oneBlockStatementClassDeclaration() {
            class innerBlocks {}
            }    

        void oneBlockStatementStatement(){
            {}
        }

        void multipleStatements(){
            final int j;
            class subBlocks {}
            {}
        }
        
        void switchStatement() {
            switch (aa) {}
            
            switch (i) {
                    case 1 :
            }
            switch (i) {
                    case j :
            }
            switch (i) {
                    default :
            }
            switch (i) {
                    case 1 : case j :
            }
            switch (i) {
                    case 1 :
                            ;
            }
            switch (i) {
                    case j :
                            ;
            }
            switch (i) {
                    default :
                            ;
            }
            switch (i) {
                    case 1 : case j :
                            ;
            }
            switch (i) {
                    case 1 :
                            ;
                    case j :
            }
            switch (i) {
                    case j :
                            ;
                    case 1 :
            }
            switch (i) {
                    case 1 :
                            ;
                    default :
            }
            switch (i) {
                    case 1 : case j :
                            ;
                    default :
                            ;
            }
                            switch (i) {
                    case 1 :
                            ;
                    case j :
                            ;
            }
            switch (i) {
                    case j :
                            ;
                    case 1 :
                            ;
            }
            switch (i) {
                    case 1 :
                            ;
                    default :
                            ;
            }
            switch (i) {
                    case 1 : case j :
                            ;
                    default :
                            ;
            }
        }
        
        void locaVariableDeclaration() {
            int a;
            int b,c;
            int d[];
            int e=3;
            int f[]={1,2};
            int g, h[];
            final int i;
        
        }
        
        void tryCatch() {
            try {}
            catch (int i) {}
                    
            try {}
            catch (int i) {}
            catch (float f) {}
                    
            try {}
            finally {}
                    
            try {}
            catch (float f) {}
            finally {}
                    
            try {}
            catch (int i) {}
            catch (float f) {}
            finally {}
        
        }
        
        void expressionStatements() {
            int i;
            i = 0;
            i++;
            ++i;
            --i;
            i--;
            i = foo1(i);
        
        }
        
        void whileStructure() {
            while (i);
        }
        
        void synchronizeKeyword() {
            synchronized (i) {}
        }
        
        
        void breakStatement() {
            int i;
            break;
            break i;
        }
        
        void returnVoid() {
            return;
                
        }
        
        void returnSomething() {
            return i==0;
        
        }
        
        void doWhile() {
            int i=1;
            do
                    i++;
            while
                    (i!=0)
            
        }
        
        
        void assertStatement() {
            int i,a,b;
            assert i == 0;
            assert a == 1 : b == 2;
        }
        
        void forStatement() {
            for (;;)
                    ;
            for (i=0;;)
                    ;
            for (int i =0;;)
                    ;
            for (i = 0, j = 0;;)
                    ;
            for (; i == 0;)
                    ;
            for (;;i=0)
                    ;
            for (;; i = 0, j = 0)
                    ;
            for (i=0;i==0;)
                    ;
            for (int i = 0;i==0;)
                    ;
            for (i = 0, j = 0;i==0;)
                    ;
            for (i=0;;i=0)
                    ;
            for (int i = 0;;i=0)
                    ;
            for (i=0, j=0;;i=0)
                    ;
            for (i=0;;i = 0, j = 0)
                    ;
            for (int i = 0;;i = 0, j = 0)
                    ;
            for (i=0, j=0;;i = 0, j = 0)
                    ;
            for (;i==0;i=0)
                    ;
            for (;i==0; i = 0, j = 0)
                    ;
            for (int i = 0;i==0;i = 0)
                    ;
            for (i = 0;i==0;i = 0)
                    ;
            for (i = 0, j = 0;i==0;i = 0)
                    ;
            for (int i = 0;i==0;i = 0, j = 0)
                    ;
            for (i = 0;i==0;i = 0, j = 0)
                    ;
            for (i = 0, j = 0;i==0;i = 0, j = 0)
                    ;
            for (int i : i==0)
                    ;
            for (final int i : j==0)
                    ;
        }
        
        void ifStatements() {
                if (i==0)
                        ;
                if (i==0)
                        ;
                else
                        ;
        }
        
        void continueStatement() {
            int i;
            continue;
            continue i;
        
        
        }
        
        void throwStatement() {
            throw e;
        }
    
    
        void emptyStatement() {
            ;
        }
        
        static {}
        
        int a;
        
        int a = 2;
        
        int a, b;
        
        {}
}



