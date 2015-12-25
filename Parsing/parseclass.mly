%token SEMICOLON EOF 
%token CLASS
%token PUBLIC PROTECTED PRIVATE ABSTRACT STATIC FINAL STRICTFP
%token LBRACE RBRACE
%token <string> TYPE IDENT
%token <float> NUMBER

%start <string> classdeclarationlist

%%

classdeclarationlist:
      ncd=normalclassdeclaration EOF { ncd }
    | ncd=normalclassdeclaration cdl=classdeclarationlist EOF { ncd^"\n"^cdl }  

normalclassdeclaration:
      CLASS id=identifier cb=classbody { "class "^id^cb } 
    | cm=classmodifier CLASS id=identifier cb=classbody { cm^" class "^id^cb}

classmodifier:
      PUBLIC { "public" }
    | PROTECTED { "protected" }
    | PRIVATE { "private" }
    | ABSTRACT { "abstract" }
    | STATIC { "static" }
    | FINAL { "final" }
    | STRICTFP { "strictfp" }

classbody:
    LBRACE RBRACE { " { ... }" }

identifier:
    id=IDENT { id }

%%
