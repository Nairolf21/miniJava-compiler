class FieldAccess {


    void fieldAccess() {
        super.x=2;
        this.x=3;
        120.x = 3;
        Cl.super.Cl.x = 4;
        void.class.x =4; 
        Cl.this.x = 4;
        ar[1].x = 4;

        //ClassName.x = 4; Didn't succeed to access class name field
    }
}
