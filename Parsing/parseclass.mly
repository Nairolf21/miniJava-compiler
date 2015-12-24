%token SEMICOLON EOF 
%token CLASS
%token LBRACE RBRACE
%token <string> TYPE IDENT
%token <float> NUMBER

%start <string> classdeclaration

%%

classdeclaration:
    ncd=normalclassdeclaration { ncd }

normalclassdeclaration:
    CLASS id=identifier classbody { "class("^id^")" } 

classbody:
    LBRACE RBRACE { "{ classbody }" }

identifier:
    id=IDENT { "ident("^id^")" }

%%
