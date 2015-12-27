%token EOF 
%token COMMA SEMICOLON LBRACE RBRACE
%token CLASS PUBLIC PROTECTED PRIVATE ABSTRACT STATIC FINAL STRICTFP
%token INT FLOAT
%token <string> IDENT
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

fieldDeclaration:
    ut=unannType vdl=variableDeclaratorList SEMICOLON { ut^" "^vdl^";"}

floatingPointType:
    FLOAT { "float" } 

identifier:
    id=IDENT { id }

integralType:
    INT { "int" } 

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^cb } 
    | cm=classModifier CLASS id=identifier cb=classBody { cm^" class "^id^cb}

numericType:
      it=integralType { it } 
    | fpt=floatingPointType { fpt } 

typeDeclaration:
    cd=classDeclaration { cd } 

unannPrimitiveType:
    nt=numericType { nt } 

unannType:
    upt=unannPrimitiveType { upt }

variableDeclarator:
    vdi=variableDeclaratorId { vdi }

variableDeclaratorId:
    id=identifier { id } 

variableDeclaratorList:
    vd=variableDeclarator { vd }
    | vd=variableDeclarator COMMA vdl=variableDeclaratorList { vd^", "^vdl }

%%
