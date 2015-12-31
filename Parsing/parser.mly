%token EOF 
%token COMMA SEMICOLON LBRACE RBRACE
%token CLASS STATIC 
%token INT FLOAT
%token <string> UIDENT LIDENT
%token <float> NUMBER

%start <string> start

%%

start:
      EOF { "eof" }
    | joel=jclass_or_expr_list EOF { joel }

jclass_or_expr_list:
      joe=jclass_or_expr { joe }
    | joe=jclass_or_expr joel=jclass_or_expr_list { joe^"\n"^joel }

jclass_or_expr:
      jc=jclass { jc }

jclass:
    CLASS ui=UIDENT LBRACE ajl=attribute_or_jmethod_list RBRACE 
        { "class "^ui^" { "^ajl^" } " }
        
attribute_or_jmethod_list:
      aoj=attribute_or_jmethod { aoj } 
    | aoj=attribute_or_jmethod ajl=attribute_or_jmethod_list { aoj^"\n"^ajl } 

attribute_or_jmethod:
    a=attribute { a } 
   
attribute:
    jt=jtype li=LIDENT SEMICOLON { jt^" "^li^";" } 

jtype:
      INT { "int" }
    | FLOAT { "float" }
    | ui=UIDENT { ui } 

%%
