%token EOF 
%token COMMA SEMICOLON LBRACE RBRACE
%token CLASS STATIC 
%token INT FLOAT
%token <string> IDENT
%token <float> NUMBER

%start <string> compilationUnitList

%%

(* expressionList:
    e=expression EOF { e }
    |  e=expression el=expressionList EOF { e^"\n"^el } 
*)

   
compilationUnitList: 
      tp=typeDeclaration EOF { tp } 
    | tp=typeDeclaration cul=compilationUnitList EOF { tp^"\n"^cul }  

typeDeclaration:
    cd=classDeclaration { cd } 

classDeclaration:
    ncd=normalClassDeclaration { ncd }

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^cb } 
    | cm=classModifier CLASS id=identifier cb=classBody { cm^" class "^id^cb}

classBody:
    LBRACE cbd=classBodyDeclaration RBRACE { " {"^cbd^" }" }

classBodyDeclaration:
    cmd=classMemberDeclaration { cmd }

classMemberDeclaration:
      fd=fieldDeclaration { fd } 
    | SEMICOLON { ";" } 
 
fieldDeclaration:
    ut=unannType vdl=variableDeclaratorList SEMICOLON { ut^" "^vdl^";"}

variableDeclaratorList:
    vd=variableDeclarator { vd }
    | vd=variableDeclarator COMMA vdl=variableDeclaratorList { vd^", "^vdl }

variableDeclarator:
    vdi=variableDeclaratorId { vdi }

variableDeclaratorId:
    id=identifier { id } 

identifier:
    id=IDENT { id }

unannType:
    upt=unannPrimitiveType { upt }

unannPrimitiveType:
    nt=numericType { nt } 

numericType:
      it=integralType { it } 
    | fpt=floatingPointType { fpt } 

integralType:
    INT { "int" } 

floatingPointType:
    FLOAT { "float" } 

classModifier:
    STATIC { "static" }

%%
