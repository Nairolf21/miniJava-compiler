%token EOF 
%token COMMA SEMICOLON LBRACE RBRACE
%token CLASS PUBLIC PROTECTED PRIVATE ABSTRACT STATIC FINAL STRICTFP
%token <string> TYPE IDENT
%token <float> NUMBER

%start <string> compilationUnitList

%%

(* expressionList:
    e=expression EOF { e }
    |  e=expression el=expressionList EOF { e^"\n"^el } 
*)

classBody:
    LBRACE cbd=classBodyDeclaration RBRACE { " {"^cbd^" }" }

classBodyDeclaration:
    cmd=classMemberDeclaration { cmd }

classDeclaration:
    ncd=normalClassDeclaration { ncd }

classMemberDeclaration:
      fd=fieldDeclaration { fd } 
    | SEMICOLON { ";" } 
    
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

declaration:
    t=TYPE id=IDENT { t^" "^id }

expression:
    | s=instruction SEMICOLON { s }

fieldDeclaration:
     t=TYPE vdl=variableDeclaratorList SEMICOLON { t^" "^vdl^";"}
    (* {fieldModifier} unnanType variableDeclaratorList ; *) 

identifier:
    id=IDENT { id }

ident_or_const:
      id=IDENT { id }
    | n=NUMBER { n }

instruction:
      dec=declaration { dec }
    | id=ident_or_const { id }

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^cb } 
    | cm=classModifier CLASS id=identifier cb=classBody { cm^" class "^id^cb}

typeDeclaration:
    cd=classDeclaration { cd } 

variableDeclarator:
    vdi=variableDeclaratorId { vdi }

variableDeclaratorId:
    id=identifier { id } 

variableDeclaratorList:
    vd=variableDeclarator { vd }
    | vd=variableDeclarator COMMA vdl=variableDeclaratorList { vd^", "^vdl }

%%
