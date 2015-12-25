%token EOF 
%token SEMICOLON LBRACE RBRACE
%token CLASS PUBLIC PROTECTED PRIVATE ABSTRACT STATIC FINAL STRICTFP
%token <string> TYPE IDENT
%token <float> NUMBER

%start <string> classDeclarationList

%%

classBody:
    LBRACE RBRACE { " { ... }" }

classDeclarationList:
      ncd=normalClassDeclaration EOF { ncd }
    | ncd=normalClassDeclaration cdl=classDeclarationList EOF { ncd^"\n"^cdl }  

classModifier:
      PUBLIC { "public" }
    | PROTECTED { "protected" }
    | PRIVATE { "private" }
    | ABSTRACT { "abstract" }
    | STATIC { "static" }
    | FINAL { "final" }
    | STRICTFP { "strictfp" }

identifier:
    id=IDENT { id }

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^cb } 
    | cm=classModifier CLASS id=identifier cb=classBody { cm^" class "^id^cb}

%%
