%token EOF 
%token SEMICOLON LBRACE RBRACE
%token CLASS PUBLIC PROTECTED PRIVATE ABSTRACT STATIC FINAL STRICTFP
%token <string> TYPE IDENT
%token <float> NUMBER

%start <string> compilationUnitList

%%

classBody:
    LBRACE RBRACE { " { ... }" }

classDeclaration:
    ncd=normalClassDeclaration { ncd }

classModifier:
      PUBLIC { "public" }
    | PROTECTED { "protected" }
    | PRIVATE { "private" }
    | ABSTRACT { "abstract" }
    | STATIC { "static" }
    | FINAL { "final" }
    | STRICTFP { "strictfp" }

compilationUnitList: 
      tp=typeDeclaration EOF { tp } 
    | tp=typeDeclaration cul=compilationUnitList EOF { tp^"\n"^cul }  

identifier:
    id=IDENT { id }

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^cb } 
    | cm=classModifier CLASS id=identifier cb=classBody { cm^" class "^id^cb}

typeDeclaration:
    cd=classDeclaration { cd } 

%%
